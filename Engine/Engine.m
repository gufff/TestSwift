//
//  Engine.m
//  yunliTextiles
//
//  Created by rety gu on 13-3-18.
//  Copyright (c) 2013年 rety gu. All rights reserved.
//

#import "Engine.h"
#import "NetCheckProtocol.h"
#import "DataLoadProtocol.h"
#import "ImageLoadProtocol.h"
#import "JSONKit.h"

static Engine* g_Engine = nil;

@implementation Engine

@synthesize asyncRequest;
@synthesize networkqueue;
@synthesize uploadNetworkqueue;
@synthesize netpl;
@synthesize imagepl;
@synthesize datapl;
/**
 * @brief
 *
 * Detailed comments of this function
 * @param[in]
 * @param[out]
 * @return
 * @note
 */
+ (id)defaultEngine {
    
    if (g_Engine == nil) {
        g_Engine = [[Engine alloc] init];
    }
    return g_Engine;
}

/**
 * @brief Asynchronous Request
 *
 * 异步请求
 * @param[in]
 * @param[out]
 * @return
 * @note
 */
-(void)asynchronousRequestWithUrl:(NSString *)url withTag:(NSInteger)tag {
    
    //构造NSUrl
    NSURL *requrl = [ NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [ASIHTTPRequest setDefaultTimeOutSeconds:15];
    self.asyncRequest = [ ASIHTTPRequest requestWithURL :requrl];
    NSLog(@"urlString :%@", requrl);
    __block ASIHTTPRequest *request = self.asyncRequest;
    request.tag = tag;
    //自定义时间超时
    [request setDelegate: self];
    [request setNumberOfTimesToRetryOnTimeout:0];
    [request startAsynchronous];
}

-(void)synchronousRequestWithUrl:(NSString *)url withTag:(NSInteger)tag {
    
    //构造NSUrl
    NSURL *requrl = [ NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [ASIHTTPRequest setDefaultTimeOutSeconds:15];
    self.asyncRequest = [ ASIHTTPRequest requestWithURL :requrl];
    NSLog(@"urlString :%@", requrl);
    __block ASIHTTPRequest *request = self.asyncRequest;
    request.tag = tag;
    //自定义时间超时
    [request setDelegate: self];
    [request setNumberOfTimesToRetryOnTimeout:0];
    [request startSynchronous];
}



#pragma mark - ASIHttpRequest Delegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
//    NSLog(@"request success");
    NSString *responseString = [request responseString];
    
    //parse string转json
    NSDictionary *dataDic = [responseString objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
    
    // 接口调用状态：1：成功 0：失败
    int state = [[dataDic objectForKey:@"state"] intValue];

    if (state == 1) {
        [self.datapl dataLoadSuccess: dataDic withTag:request.tag];
    } else {
        //处理失败
        NSString *errMessage = [dataDic objectForKey:@"msg"];
        
        [self.datapl dataLoadFail:errMessage withTag:request.tag];
    }
    
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"request failed");

    NSError *error = [request error];
    NSString *errMessage = [[error userInfo] objectForKey:@"NSLocalizedDescription"];
    // 网路请求失败
    [self.netpl netcheckFail:errMessage withTag:request.tag];
    
}

/**
 * @brief cancelAsynchronousRequest
 *
 * 取消异步请求
 * @param[in]
 * @param[out]
 * @return
 * @note
 */
-(void)cancelAsynchronousRequest {
    
    if (self.asyncRequest != nil) {
        [self.asyncRequest clearDelegatesAndCancel];//清除代理并取消异步请求
        self.asyncRequest = nil;//删除请求句柄
    }
}


/**
 * @brief downloadImage
 *
 * Detailed comments of this function
 * @param[in] url：图片地址 localName：图片本地存储名
 * @param[out]
 * @return
 * @note
 */
-(void)downloadImage:(NSString *)url withLocalName:(NSString *)localName withRequestTag:(NSInteger)tag {
    if (networkqueue == nil) {
        networkqueue = [[ASINetworkQueue alloc] init];//创建新的请求队列
        
        [networkqueue reset];//重置队列
        [networkqueue setRequestDidFinishSelector:@selector(imageFetchComplete:)];//设置图片下载完成后处理方法
        [networkqueue setRequestDidFailSelector:@selector(imageFetchFailed:)];//设置图片下载失败后处理方法
        [networkqueue setDelegate:self];//设置代理
    }
    
    //构造http请求，并未图片在本地存储命名
    ASIHTTPRequest *request;
    [ASIHTTPRequest setDefaultTimeOutSeconds:20];

    NSURL *urlEncoding = [ NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    request = [[[ASIHTTPRequest alloc] initWithURL:urlEncoding]autorelease];
    [ request setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy ];
    //设置图片缓存路径
    [request setDownloadDestinationPath:[[NSHomeDirectory()stringByAppendingPathComponent:@"Library/Caches"]stringByAppendingPathComponent:localName]];
    request.timeOutSeconds = 10;
    request.tag = tag;
    [request setUserInfo:[NSDictionary dictionaryWithObject:localName forKey:@"name"]];
    [networkqueue setUserInfo:[NSDictionary dictionaryWithObject:localName forKey:@"name"]];
    [networkqueue addOperation:request];
    
    //执行下载请求
    [networkqueue go];
}

/**
 * @brief cancel Download Images
 *
 * 取消图片下载
 * @param[in]
 * @param[out]
 * @return
 * @note
 */
-(void)cancelDownloadImages {
    if (self.networkqueue != nil) {
        NSLog(@"imageLoad cancel");

        [self.networkqueue cancelAllOperations];
        self.networkqueue = nil;
        
    }
}

/**
 * @brief complete to download Image
 *
 * Detailed comments of this function
 * @param[in]
 * @param[out]
 * @return
 * @note
 */
- (void)imageFetchComplete:(ASIHTTPRequest *)request{

    UIImage *img = [UIImage imageWithContentsOfFile:[request downloadDestinationPath]];
    if (img) {
        NSLog(@"imageLoad success");
        [self.imagepl refreshImageWithTag:request.tag ];//调用代理方法
    }
}

/**
 * @brief failed to download Image
 *
 * Detailed comments of this function
 * @param[in]
 * @param[out]
 * @return
 * @note
 */
- (void)imageFetchFailed:(ASIHTTPRequest *)request{

    if([[request error] domain] !=NetworkRequestErrorDomain || [[request error]code] !=ASIRequestCancelledErrorType) {
        NSDictionary *userInfoDic = self.networkqueue.userInfo;
        NSString *localName = [userInfoDic objectForKey:@"name"];
        NSString *localPath = [[NSHomeDirectory()stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:localName] ;
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:localPath error:nil];
        NSLog(@"imageLoad failed");
    }
}

// 上传图片
- (void)uploadPhotoWithUrl:(NSString *)url withDataDic:(NSDictionary *)dataDic withTag:(NSInteger)tag
{
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL: [NSURL URLWithString: url]];
    request.tag = tag;
    if (tag == requestTagWithCommmentAddImage) {
        // 发表评论
        [request setPostValue: [dataDic objectForKey:@"objectId"] forKey: @"objectId"];
        [request setPostValue: [dataDic objectForKey:@"replyContent"] forKey: @"replyContent"];
        [request setPostValue: [dataDic objectForKey:@"userId"] forKey: @"userId"];
        [request setPostValue: [dataDic objectForKey:@"replyId"] forKey: @"replyId"];
        [request setPostValue: [dataDic objectForKey:@"type"] forKey: @"type"];
        if (![[dataDic objectForKey:@"replyImg"] isEqualToString:@""]) {
            // 有图片
            [request setFile:[dataDic objectForKey:@"replyImg"] forKey:@"replyImg"];
        }
    } else if (tag == requestTagWithApplyTopic) {
        // 话题发布
        [request setPostValue: [dataDic objectForKey:@"socId"] forKey: @"socId"];
        [request setPostValue: [dataDic objectForKey:@"talkTitle"] forKey: @"talkTitle"];
        [request setPostValue: [dataDic objectForKey:@"userId"] forKey: @"userId"];
        [request setPostValue: [dataDic objectForKey:@"talkContent"] forKey: @"talkContent"];
        if (![[dataDic objectForKey:@"talkImg"] isEqualToString:@""]) {
            // 有图片
            [request setFile:[dataDic objectForKey:@"talkImg"] forKey:@"talkImg"];
        }
    } else if (tag == requestTagAddNews) {
        // 说吧发布
        [request setPostValue: [dataDic objectForKey:@"title"] forKey: @"title"];
        [request setPostValue: [dataDic objectForKey:@"userId"] forKey: @"userId"];
        [request setPostValue: [dataDic objectForKey:@"content"] forKey: @"content"];
        if (![[dataDic objectForKey:@"newsLetterImg"] isEqualToString:@""]) {
            // 有图片
            [request setFile:[dataDic objectForKey:@"newsLetterImg"] forKey:@"newsLetterImg"];
        }
    }  else if (tag == requestTagWithApplyActivity) {
        // 活动发布
        [request setPostValue: [dataDic objectForKey:@"socId"] forKey: @"socId"];
        [request setPostValue: [dataDic objectForKey:@"activityContent"] forKey: @"activityContent"];
        [request setPostValue: [dataDic objectForKey:@"startTime"] forKey: @"startTime"];
        [request setPostValue: [dataDic objectForKey:@"endTime"] forKey: @"endTime"];
        [request setPostValue: [dataDic objectForKey:@"userId"] forKey: @"userId"];
        [request setPostValue: [dataDic objectForKey:@"location"] forKey: @"location"];
        [request setPostValue: [dataDic objectForKey:@"teacherName"] forKey: @"teacherName"];
        [request setPostValue: [dataDic objectForKey:@"teacherPhone"] forKey: @"teacherPhone"];
        [request setPostValue: [dataDic objectForKey:@"activityTitle"] forKey: @"activityTitle"];
        [request setPostValue: [dataDic objectForKey:@"isPublic"] forKey: @"isPublic"];
        [request setPostValue: [dataDic objectForKey:@"isAddPc"] forKey: @"isAddPc"];
        
        if (![[dataDic objectForKey:@"activityImg"] isEqualToString:@""]) {
            // 有图片
            [request setFile:[dataDic objectForKey:@"activityImg"] forKey:@"activityImg"];
        }
    } else if (tag == requestTagApplyOrg) {
        // 社团申请
        [request setPostValue: [dataDic objectForKey:@"socName"] forKey: @"socName"];
        [request setPostValue: [dataDic objectForKey:@"teacherName"] forKey: @"teacherName"];
        [request setPostValue: [dataDic objectForKey:@"teacherPhone"] forKey: @"teacherPhone"];
        [request setPostValue: [dataDic objectForKey:@"remark"] forKey: @"remark"];
        [request setPostValue: [dataDic objectForKey:@"userId"] forKey: @"userId"];
    } else if (tag == requestTagUpdateSocInfo) {
        // 修改社团信息
        [request setPostValue: [dataDic objectForKey:@"socId"] forKey: @"socId"];
        [request setPostValue: [dataDic objectForKey:@"socDesc"] forKey: @"socDesc"];
        [request setPostValue: [dataDic objectForKey:@"gloryContent"] forKey: @"gloryContent"];
        if (![[dataDic objectForKey:@"socImg"] isEqualToString:@""]) {
            // 有图片
            [request setFile:[dataDic objectForKey:@"socImg"] forKey:@"socImg"];
        }
    } else if (tag == requestTagSearchSociety) {
        // 社团搜索
        [request setPostValue: [dataDic objectForKey:@"schoolId"] forKey: @"schoolId"];
        [request setPostValue: [dataDic objectForKey:@"socName"] forKey: @"socName"];
    }  else if (tag == requestTagSearchActivity) {
        // 活动搜索
        [request setPostValue: [dataDic objectForKey:@"schoolId"] forKey: @"schoolId"];
        [request setPostValue: [dataDic objectForKey:@"activityTitle"] forKey: @"activityTitle"];
    }  else if (tag == requestTagSearchTopic) {
        // 话题搜索
        [request setPostValue: [dataDic objectForKey:@"schoolId"] forKey: @"schoolId"];
        [request setPostValue: [dataDic objectForKey:@"talkTitle"] forKey: @"talkTitle"];
    } else if (tag == requestTagUpdateUserInfo) {
        // 修改用户信息
        [request setPostValue: [dataDic objectForKey:@"userId"] forKey: @"userId"];
        [request setPostValue: [dataDic objectForKey:@"nickName"] forKey: @"nickName"];
        [request setPostValue: [dataDic objectForKey:@"sex"] forKey: @"sex"];
        [request setPostValue: [dataDic objectForKey:@"userAge"] forKey: @"userAge"];
        [request setPostValue: [dataDic objectForKey:@"userAccount"] forKey: @"userAccount"];
        [request setPostValue: [dataDic objectForKey:@"userStudentID"] forKey: @"userStudentID"];
        [request setPostValue: [dataDic objectForKey:@"realName"] forKey: @"realName"];
        
        if (![[dataDic objectForKey:@"userHeadImg"] isEqualToString:@""]) {
            // 有图片
            [request setFile:[dataDic objectForKey:@"userHeadImg"] forKey:@"userHeadImg"];
        }
    } else if (tag == requestTagSendMessage) {
        // 发送聊天信息
        [request setPostValue: [dataDic objectForKey:@"fromUserId"] forKey: @"fromUserId"];
        [request setPostValue: [dataDic objectForKey:@"toUserId"] forKey: @"toUserId"];
        [request setPostValue: [dataDic objectForKey:@"content"] forKey: @"content"];
        [request setPostValue: [dataDic objectForKey:@"type"] forKey: @"type"];
    } else if (tag == requestTagSearchFriend) {
        [request setPostValue: [dataDic objectForKey:@"keyword"] forKey: @"keyword"];
    } else if (tag == requestTagUpdateOrgNotice) {
        // 修改社团公告
        [request setPostValue: [dataDic objectForKey:@"socId"] forKey: @"socId"];
        [request setPostValue: [dataDic objectForKey:@"noticeTitle"] forKey: @"noticeTitle"];
        [request setPostValue: [dataDic objectForKey:@"noticeContent"] forKey: @"noticeContent"];
    } else if (tag == requestTagReport) {
        // 举报
        [request setPostValue: [dataDic objectForKey:@"userId"] forKey: @"userId"];
        [request setPostValue: [dataDic objectForKey:@"content"] forKey: @"content"];
        [request setPostValue: [dataDic objectForKey:@"reportId"] forKey: @"reportId"];
        [request setPostValue: [dataDic objectForKey:@"type"] forKey: @"type"];
    } else if (tag == requestTagFeedBack) {
        // 意见反馈
        [request setPostValue: [dataDic objectForKey:@"userId"] forKey: @"userId"];
        [request setPostValue: [dataDic objectForKey:@"content"] forKey: @"content"];
        [request setPostValue: [dataDic objectForKey:@"operatingSys"] forKey: @"operatingSys"];
    } else if (tag == requestTagCreateBangbang) {
        // 创建帮帮团
        [request setPostValue: [dataDic objectForKey:@"userId"] forKey: @"userId"];
        [request setPostValue: [dataDic objectForKey:@"teamName"] forKey: @"teamName"];
        [request setPostValue: [dataDic objectForKey:@"teamSummary"] forKey: @"teamSummary"];
        [request setPostValue: [dataDic objectForKey:@"address"] forKey: @"address"];
        [request setPostValue: [dataDic objectForKey:@"linkman"] forKey: @"linkman"];
        [request setPostValue: [dataDic objectForKey:@"linkmanPhone"] forKey: @"linkmanPhone"];
        [request setPostValue: [dataDic objectForKey:@"teamId"] forKey: @"teamId"];
    } else if (tag == requestTagBangbangList) {
        // 帮帮列表
        [request setPostValue: [dataDic objectForKey:@"userId"] forKey: @"userId"];
        [request setPostValue: [dataDic objectForKey:@"teamName"] forKey: @"teamName"];
        [request setPostValue: [dataDic objectForKey:@"pageNo"] forKey: @"pageNo"];
        [request setPostValue: [dataDic objectForKey:@"dynamicTime"] forKey: @"dynamicTime"];
    } else if (tag == requestTagBangbangSelf) {
        // 帮帮收藏
        [request setPostValue: [dataDic objectForKey:@"userId"] forKey: @"userId"];
        [request setPostValue: [dataDic objectForKey:@"teamName"] forKey: @"teamName"];
        [request setPostValue: [dataDic objectForKey:@"pageNo"] forKey: @"pageNo"];
        [request setPostValue: [dataDic objectForKey:@"dynamicTime"] forKey: @"dynamicTime"];
    } else if (tag == requestTagBangbangCommentAdd) {
        // 添加帮帮评论
        [request setPostValue: [dataDic objectForKey:@"userId"] forKey: @"userId"];
        [request setPostValue: [dataDic objectForKey:@"teamId"] forKey: @"teamId"];
        [request setPostValue: [dataDic objectForKey:@"parentId"] forKey: @"parentId"];
        [request setPostValue: [dataDic objectForKey:@"type"] forKey: @"type"];
        [request setPostValue: [dataDic objectForKey:@"commentContent"] forKey: @"commentContent"];
    } else if (tag == requestTagCreateXiaoyuantao) {
        // 创建校园淘
        [request setPostValue: [dataDic objectForKey:@"userId"] forKey: @"userId"];
        [request setPostValue: [dataDic objectForKey:@"commodityName"] forKey: @"commodityName"];
        [request setPostValue: [dataDic objectForKey:@"commoditySummary"] forKey: @"commoditySummary"];
        [request setPostValue: [dataDic objectForKey:@"commodityPrice"] forKey: @"commodityPrice"];
        [request setPostValue: [dataDic objectForKey:@"linkman"] forKey: @"linkman"];
        [request setPostValue: [dataDic objectForKey:@"linkmanPhone"] forKey: @"linkmanPhone"];
        [request setPostValue: [dataDic objectForKey:@"commodityId"] forKey: @"commodityId"];
    } else if (tag == requestTagGetMyXiaoyuantao) {
        // 我的校园淘
        [request setPostValue: [dataDic objectForKey:@"userId"] forKey: @"userId"];
        [request setPostValue: [dataDic objectForKey:@"nowPage"] forKey: @"nowPage"];
    } else if (tag == requestTagGetJianzhiList) {
        // 勤工俭学列表
        [request setPostValue: [dataDic objectForKey:@"type"] forKey: @"type"];
        [request setPostValue: [dataDic objectForKey:@"pageNo"] forKey: @"pageNo"];
        [request setPostValue: [dataDic objectForKey:@"title"] forKey: @"title"];
        
    } else if (tag == requestTagUpdateResume) {
        // 修改个人简历
        [request setPostValue: [dataDic objectForKey:@"userId"] forKey: @"userId"];
        [request setPostValue: [dataDic objectForKey:@"isOpen"] forKey: @"isOpen"];
        [request setPostValue: [dataDic objectForKey:@"jobIntension"] forKey: @"jobIntension"];
        [request setPostValue: [dataDic objectForKey:@"userIntroduction"] forKey: @"userIntroduction"];
        [request setPostValue: [dataDic objectForKey:@"positionType"] forKey: @"positionType"];
    } else if (tag == requestTagFriendRemak) {
        // 修改好友备注
        [request setPostValue: [dataDic objectForKey:@"selfId"] forKey: @"selfId"];
        [request setPostValue: [dataDic objectForKey:@"friendId"] forKey: @"friendId"];
        [request setPostValue: [dataDic objectForKey:@"noteName"] forKey: @"noteName"];
    } else if (tag == requestTagGroupSendMessage) {
        //群发私信
        [request setPostValue: [dataDic objectForKey:@"content"] forKey:@"content"];
        [request setPostValue: [dataDic objectForKey:@"fromUserId"] forKey:@"fromUserId"];
        [request setPostValue: [dataDic objectForKey:@"toUserIds"] forKey:@"toUserIds"];
    }
    [request setRequestMethod:@"POST"];
    [request setDelegate:self];
    [request startAsynchronous];
}

-(void)uploadImage:(NSString *)url withDataDic:(NSDictionary *)dataDic {
    if (uploadNetworkqueue == nil) {
        uploadNetworkqueue = [[ASINetworkQueue alloc] init];//创建新的请求队列
        [uploadNetworkqueue reset];//重置队列
        [uploadNetworkqueue setRequestDidFinishSelector:@selector(imageUploadComplete:)];//设置图片上传完成后处理方法
        [uploadNetworkqueue setRequestDidFailSelector:@selector(imageUploadFailed:)];//设置图片上传失败后处理方法
        [uploadNetworkqueue setDelegate:self];//设置代理
        [uploadNetworkqueue setUploadProgressDelegate:self];
    }
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL: [NSURL URLWithString: url]];
    [request setCacheStoragePolicy:ASICachePermanentlyCacheStoragePolicy ];
    [request setPostValue: [dataDic objectForKey:@"proId"] forKey: @"proId"];
    [request setPostValue: [dataDic objectForKey:@"proType"] forKey: @"proType"];
    [request setFile:[dataDic objectForKey:@"images"] forKey:@"images"];
    request.timeOutSeconds = 30;
    [request setRequestMethod:@"POST"];
    [uploadNetworkqueue addOperation:request];
    //执行下载请求
    [uploadNetworkqueue go];
}

- (void)imageUploadComplete:(ASIHTTPRequest *)request {
    NSString *responseString = [request responseString];
    
    //parse string转json
    NSDictionary *dataDic = [responseString objectFromJSONStringWithParseOptions:JKParseOptionLooseUnicode];
    
    // 接口调用状态：1；成功 0：失败
    int state = [[dataDic objectForKey:@"state"] intValue];
    if (state == 1) {
        [self.progresspl uploadSuccess:dataDic];
    }
    
}

- (void)imageUploadFailed:(ASIHTTPRequest *)request {
    [self.progresspl uploadFailed];
}

//- (void)setProgress:(float)newProgress {
//    [self.progresspl showProgress:newProgress];
//}

-(void) dealloc {
    self.asyncRequest = nil;
    self.networkqueue = nil;
    self.uploadNetworkqueue = nil;
    [super dealloc];
}

@end
