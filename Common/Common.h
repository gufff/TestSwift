//
//  Common.h
//  yunliTextiles
//  Created by rety gu on 13-3-18.
//  Copyright (c) 2013年 rety gu. All rights reserved.


#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <UIKit/UIKit.h>

@interface Common : NSObject

#define DB_NAME_CONTACTERS      @"ntsociety.sqlite3"
#define DB_NAME_MASTER          @"Master.sqlite"

// 服务器地址
#define PRE_URL                @"http://192.168.1.253:8088/yahinterface/"
#define PRE_IMAGE_URL          @"http://192.168.1.253:8809/"

//#define PRE_URL                @"http://192.168.1.99:8082/yahinterface/"
//#define PRE_IMAGE_URL          @"http://192.168.1.8:8089"


//#define PRE_URL                @"http://58.221.90.226:9008/yahinterface/"
//#define PRE_IMAGE_URL          @"http://pic.yaheii.com/"

#define ADVERT_IS_UPDATE       @"app/userInfoInterface/getWelcomePage?"      // 判断启动广告页是否有更新
#define AUTH_CODE              @"app/userInfoInterface/sendCheck?"         // 短信验证码
#define AUTH_CODE_CONFIRM      @"app/userInfoInterface/userCheck?"         // 短信验证码验证
#define LOGIN                  @"app/userInfoInterface/userLogin?"         // 登录
#define SIGNUP                 @"app/userInfoInterface/userRegister?"      // 注册
#define SCHOOL_IS_UPDATE       @"app/userInfoInterface/isUpdateDate?"      // 判断学校是否跟新
#define GET_SCHOOL_LIST        @"app/userInfoInterface/getSchoolList"      // 获取学校列表
#define GET_RECOMMEND_LIST     @"app/noticeAdvertisementInterface/getIndexTjList?"    // 获取首页热门推荐
#define GET_NOTICE_LIST        @"app/noticeAdvertisementInterface/getInfoList?"       // 获取首页公告
#define GET_NOTICE_DETAIL      @"app/noticeAdvertisementInterface/getInfo?"           // 获取首页公告详情
#define GET_VOTE               @"app/noticeAdvertisementInterface/getVote?"              // 获取首页投票
#define SEARCTH_SOCIETY        @"app/communityInfoInterface/searchSoc"          // 检索社团
#define SEARCTH_ACTIVITY       @"app/activityInformationInterface/searchActivity"     // 检索活动
#define SEARCTH_TOPIC          @"app/discussInfoInterface/searchTalk"         // 检索话题
#define MY_ORGANIZATIONS       @"app/communityInfoInterface/getMySocietiesList?"// 我的社团
#define ORGANIZATION_DETAIL    @"app/communityInfoInterface/getSocietiesInfo?"  // 社团详情
#define DYNAMIC_LIST           @"app/communityInfoInterface/getSocDynamicList?" // 社团活动、话题列表
#define MEMBER_LIST            @"app/communityInfoInterface/getSocGroup?"       // 社团成员列表
#define ORG_INTRODUCE          @"app/communityInfoInterface/getSocDetailed?"    // 社团介绍
#define ORG_NOTICE             @"app/communityInfoInterface/getSocNotices?"       // 获取社团公告
#define UPDATE_ORG_NOTICE      @"app/communityInfoInterface/updateSocNotice?"    // 修改社团公告
#define ORG_SIGN_IN            @"app/communityInfoInterface/registration?"      // 社团签到
#define APPLY_FOR_ORG          @"app/communityInfoInterface/addSocieties"       // 社团申请
#define TALK_DETAIL            @"app/discussInfoInterface/getTalkInfo?"       // 获取话题详情
#define ACTIVITY_DETAIL        @"app/activityInformationInterface/getActivityInfo?"   // 获取活动详情
#define ADD_TALK               @"app/discussInfoInterface/addTalk"            // 发布话题
#define ADD_TALK_IMG           @"app/discussInfoInterface/addTalkImg"         // 发布话题带图片
#define ADD_ACTIVITY           @"app/activityInformationInterface/addActivity"        // 发布活动
#define ADD_ACTIVITY_IMG       @"app/activityInformationInterface/addActivityImg"     // 发布活动带图片
#define COMMENT_LIST           @"app/discussInfoInterface/getReplyList?"      // 评论列表
#define ADD_COMMENT            @"app/discussInfoInterface/reply?"             // 发表评论
#define ADD_COMMENT_IMG        @"app/discussInfoInterface/replyImg"           // 发表评论带图片
#define COMMENT_LIST_BY_FLOOR  @"app/discussInfoInterface/getReplyByReplyId?" // 楼层回复列表
#define ADD_FAV_ACTIVITY       @"app/discussInfoInterface/addLaud?"           // 活动、话题添加喜欢
#define CANCEL_FAV_ACTIVITY    @"app/discussInfoInterface/delLaud?"           // 活动、话题取消喜欢
#define ADD_SUPPORT_ACTIVITY   @"app/discussInfoInterface/addZan?"            // 活动、话题添加赞
#define CANCEL_SUPPORT_ACTIVITY @"app/discussInfoInterface/delZan?"           // 活动、话题取消赞
#define ADD_TOP_ACTIVITY       @"app/discussInfoInterface/isTop?"             // 活动、话题置顶/取消置顶
#define DELETE_ACTIVITY        @"app/discussInfoInterface/delDynamic?"        // 活动、话题删除
#define PUBLIC_ACTIVITY        @"app/activityInformationInterface/publicActivityInfo?"// 活动公开
#define UPDATE_SOCINFO         @"app/communityInfoInterface/updateSocInfo"      // 修改社团信息
#define UPDATE_SOCINFO_IMG     @"app/communityInfoInterface/updateSocInfoImg"   // 修改社团信息带图片
#define APPLY_ACTIVITY         @"app/activityInformationInterface/applyActivity?"     // 活动报名
#define DELETE_COMMMENT        @"app/discussInfoInterface/delReply?"          // 删除评论
#define GET_USER_INFO          @"app/userInfoInterface/getUserInfo?"       // 获取用户信息
#define GET_USER_PUBLISH_LIST  @"app/userInfoInterface/getMyDynamicList?"  // 获取用户发布列表
#define GET_USER_FAV_LIST      @"app/discussInfoInterface/getMyLikeList?"     // 获取用户收藏列表
#define GET_USER_SOC_LIST      @"app/communityInfoInterface/getUserSocietiesList?" // 获取用户社团列表
#define GET_USER_ACTIVITY_LIST @"app/activityInformationInterface/getMyAppActivityList?" // 获取用户参加活动列表
#define GET_USER_COMMENT_LIST  @"app/discussInfoInterface/getDynamicListByReply?"// 获取用户评论列表
#define UPDATE_USER_INFO       @"app/userInfoInterface/updateUser?"        // 修改用户信息
#define UPDATE_USER_INFO_IMG   @"app/userInfoInterface/updateUserImg?"     // 修改用户信息带头像
#define SEND_MESSAGE           @"app/userInfoInterface/sendPrivateLetter"  // 发送私信信息
#define GET_MESSAGE_LIST       @"app/userInfoInterface/getPrivateLetterdDetail?" // 发送聊天列表
#define GET_LETTER_LIST        @"app/userInfoInterface/getUnreadPrivateLetter?"  // 获取私信列表
#define JOIN_MASS              @"app/userInfoInterface/sendPrivateLetter?" // 加入社团
#define AGREE_JOIN_MASS        @"app/communityInfoInterface/joinSoc?"           // 同意、拒绝加入社团
#define AGREE_ADD_FRIEND       @"app/userInfoInterface/addFriend?"         // 同意、拒绝加为好友
#define CONTACTER_LIST         @"app/userInfoInterface/getFriend?"         // 获取联系人列表
#define REMOVE_CONTACTER       @"app/userInfoInterface/delFriend?"         // 删除好友
#define SEARCH_FRIENDS         @"app/userInfoInterface/searchUser"        // 好友检索
#define FRIEND_REMARK          @"app/userInfoInterface/editFriend"         // 好友备注
#define CHECK_IS_CONTACTER     @"app/userInfoInterface/checkphone?"        // 判断通讯录联系人类别
#define ACTIVITY_MEMBER_LIST   @"app/activityInformationInterface/getActivityAppUser?"// 获取活动报名人员列表
#define ADD_NEWS               @"app/discussInfoInterface/addNewsLetter?"     // 发布说吧
#define ADD_NEWS_IMAGE         @"app/discussInfoInterface/addNewsLetterImg?"  // 发布说吧带图片
#define GET_NEWS_LST           @"app/discussInfoInterface/getInfoDynamicList?"// 获取说吧列表
#define GET_NEWS_DETAIL        @"app/discussInfoInterface/getTbInfo?"         // 获取说吧详情
#define MASS_MAKE_OVER         @"app/communityInfoInterface/zrScoieties?"       // 社团成员管理、团长转让
#define MASS_ADD_MAMAGER       @"app/communityInfoInterface/changeDeputyBoss?"     // 社团成员管理、设置/取消副团长
#define MASS_DEL_MAMAGER       @"app/communityInfoInterface/changeDeputyBoss?"     // 社团成员管理、取消副团长
#define MASS_DEL_MEMBER        @"app/communityInfoInterface/delSocGroupUser?"   // 社团成员管理、删除成员
#define REPORT                 @"app/discussInfoInterface/report?"            // 举报
#define CHANGE_PASSWORD        @"app/userInfoInterface/updatePassWord?"         // 修改密码
#define FEED_BACK              @"app/userInfoInterface/addFeedback"        // 意见反馈
#define CHECK_UPDATE           @"app/userInfoInterface/checkVersion?"      // 检测版本更新
#define FORGET_PW              @"app/userInfoInterface/getNewPwd?"         // 密码找回
#define FIND_PW_BY_PHONE       @"app/userInfoInterface/sendCheckByGetPassWord?" // 短信密码找回
#define FIND_PW_BY_PHONE_CHECK @"app/userInfoInterface/userCheckByGetPassWord?" // 短信密码找回验证码验证
#define FIND_PW_BY_PHONE_CHANGE @"app/userInfoInterface/changePassWordByPhone?" // 短信密码找回修改密码

// 二期
#define WORKSTUDY_HOME         @"app/noticeAdvertisementInterface/getIndexTj?"          // 社会实践首页
#define CREATE_BANGBANG        @"app/socialPracticeInfoInterface/addTeam"             // 创建帮帮团
#define CREATE_BANGBANG_IMG    @"app/userInfoInterface/addImg"              // 创建帮帮团上传图片
#define DELETE_BANGBANG_IMG    @"app/userInfoInterface/delImg"              // 删除帮帮团上传图片
#define CREATE_BANGBANG_LIST   @"app/socialPracticeInfoInterface/getTeamList"         // 帮帮列表
#define BANGBANG_DETAIL        @"app/socialPracticeInfoInterface/getTeamById?"        // 帮帮详情
#define BANGBANG_COLLECT       @"app/socialPracticeInfoInterface/addAttention?"       // 帮帮收藏
#define BANGBANG_DIS_COLLECT   @"app/socialPracticeInfoInterface/delAttention?"       // 帮帮取消收藏
#define BANGBANG_CLOSE         @"app/socialPracticeInfoInterface/changeTeamState?"    // 帮帮开启、关闭
#define BANGBANG_UPDATE_INFO   @"app/socialPracticeInfoInterface/updateTeam?"         // 帮帮信息修改
#define BANGBANG_FAVOURITE     @"app/socialPracticeInfoInterface/getMyLikeTeamList"   // 我关注的帮帮
#define BANGBANG_COMMENT_LIST  @"app/socialPracticeInfoInterface/getTeamCommentList?" // 帮帮评论列表
#define BANGBANG_COMMENT_ADD   @"app/socialPracticeInfoInterface/addComment"          // 帮帮添加评论
#define BANGBANG_COMMENT_DELETE @"app/socialPracticeInfoInterface/delTeamComment?"    // 帮帮删除评论
#define CREATE_XIAOYUANTAO     @"app/socialPracticeInfoInterface/addCommodity"        // 校园淘发布
#define GET_XIAOYUANTAO_LIST   @"app/socialPracticeInfoInterface/getCommodityList?"   // 校园淘列表
#define GET_XIAOYUANTAO_Detail @"app/socialPracticeInfoInterface/getCommodityById?"   // 校园淘详情
#define XIAOYUANTAO_Update     @"app/socialPracticeInfoInterface/updateCommodity"     // 校园淘修改
#define MY_XIAOYUANTAO         @"app/socialPracticeInfoInterface/getMyCommodityList"  // 我发布的校园淘
#define XIAOYUANTAO_CLOSE      @"app/socialPracticeInfoInterface/delCommodity?"       // 校园淘下架
#define JIANZHI_LIST           @"app/socialPracticeInfoInterface/getPositionList"     // 兼职实习列表
#define JIANZHI_DETAIL         @"app/socialPracticeInfoInterface/getPositionById?"    // 兼职实习详情
#define JIANZHI_COLLECT        @"app/socialPracticeInfoInterface/addNewAttention?"    // 兼职实习收藏
#define JIANZHI_DIS_COLLECT    @"app/socialPracticeInfoInterface/delNewAttention?"    // 兼职实习取消收藏
#define GET_COMPANY_ALL_POSITION   @"app/socialPracticeInfoInterface/getOtherPositionList?" // 兼职实习获取公司所有职位
#define GET_COLLECTED_POSITION @"app/socialPracticeInfoInterface/getMyLikePositionList?" // 兼职实习收藏的职位
#define GET_RESUME             @"app/socialPracticeInfoInterface/getResume?"           // 获取个人简历
#define UPDATE_RESUME          @"app/socialPracticeInfoInterface/updateResume"         // 修改个人简历
#define UPLOAD_RESUME_IMAGE    @"app/userInfoInterface/addImgForCard"        // 上传个人简历
#define UPLOAD_MEMBER_CENTER_BG    @"app/userInfoInterface/addImg"    // 修改个人中心背景图片
#define CANCEL_ACTIVITY_SPONSOR    @"app/activityInformationInterface/delIsAddPc?"                  // 取消寻求赞助
#define SEND_GROUPMESSAGE      @"app/userInfoInterface/sendMassPrivateLetter"            //私信群发


#define IS_LOGIN               @"is_login"
#define MEMBER_ID              @"member_id"
#define IS_UPLOAD_CARD         @"is_upload_card"

#define NOT_LOGIN    9999

#define ADDRESS_DETAIL_ID      @"address_detail_id"
#define TEL_NUM                @"tel"
#define SCHOOL_VISION          @"school_vision"
#define DEVICE_TOKEN           @"deviceToken"
#define UPLOAD_IMG_PATH     [NSHomeDirectory()stringByAppendingPathComponent:@"Library/Caches/uploadCache"]

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define sys_version_ForiOS7  ( [[[UIDevice currentDevice]  systemVersion] floatValue] >= 7.0)

#define rootView [[[[[UIApplication sharedApplication] windows] objectAtIndex:0] rootViewController] view]

// 请求类型
typedef NS_ENUM(NSInteger, requestTag)
{
    requestTagWithLogin,
    requestTagWithSignup,
    requestTagWithAuthCode,
    requestTagWithComfirmAuthCode,
    requestTagWithMemberList,
    requestTagWithMySocieties,
    requestTagWithSchoolIsUpdate,
    requestTagWithAdvertIsUpdate,
    requestTagWithNotificationIsUpdate,
    requestTagWithSchoolList,
    requestTagSocDynamicList,
    requestTagGetSocietiesInfo,
    requestTagMassSignin,
    requestTagJoinMass,
    requestTagGeRegistration,
    requestTagWithSocDetailed,
    requestTagWithSocIntroduce,
    requestTagWithOtherSocDetailed,
    requestTagWithCommmentList,
    requestTagCommentDetailList,
    requestTagWithCommmentAddImage,
    requestTagWithApplyActivity,
    requestTagWithApplyTopic,
    requestTagWithCommentAdd,
    requestTagTopicDetail,
    requestTagActivityDetail,
    requestTagFriendRemak,
    requestTagApplyOrg,
    requestTagAddFav,
    requestTagCancelFav,
    requestTagAddSupport,
    requestTagCancelSupport,
    requestTagAddTop,
    requestTagDeleteActivity,
    requestTagPublicActivity,
    requestTagUpdateSocInfo,
    requestTagApplyActivity,
    requestTagDeleteComment,
    requestTagDeleteFloor,
    requestTagSearchSociety,
    requestTagSearchActivity,
    requestTagSearchTopic,
    requestTagMemberCenter,
    requestTagMemberCenterBg,
    requestTagMemberPublish,
    requestTagFavTheme,
    requestTagMemberCommentList,
    requestTagUserFavList,
    requestTagUserActivityList,
    requestTagUpdateUserInfo,
    requestTagSendMessage,
    requestTagMessageList,
    requestTagPrivateLetterList,
    requestTagRejectSignin,
    requestTagAgreeSignin,
    requestTagRejectFriend,
    requestTagAgreeFriend,
    requestTagMemberFriendsList,
    requestTagRemoveFriend,
    requestTagSearchFriend,
    requestTagCheckIsContacter,
    requestTagActivityJoinMember,
    requestTagAddNews,
    requestTagGetNewsList,
    requestTagGetRecommendList,
    requestTagGetHomeNoticeList,
    requestTagGetHomeNoticeDetail,
    requestTagGetHomeVoteDetail,
    requestTagGetShopStoreList,
    requestTagGetShopStoreDetail,
    requestTagExchangeCommodity,
    requestTagMyCommodities,
    requestTagMyCommodity,
    requestTagOrgNotice,
    requestTagUpdateOrgNotice,
    requestTagYunbiDetail,
    requestTagConsumeRecode,
    requestTagYunbiExchangeCount,
    requestTagYunbiExchange,
    requestTagMassYunbiDetail,
    requestTagMassYunbiRecord,
    requestTagDonateHome,
    requestTagDonateYunbi,
    requestTagMassContribute,
    requestTagMassMakeOver,
    requestTagMassAddMamager,
    requestTagMassDelMamager,
    requestTagMassDelMember,
    requestTagReport,
    requestTagFeedBack,
    requestTagChangePasword,
    requestTagCheckVersion,
    requestTagFindPwByPhone,
    requestTagFindPwByPhoneCheck,
    requestTagFindPwByPhoneChange,
    requestTagGetWorkStudyList,    // 二期
    requestTagCreateBangbang,
    requestTagUploadBangbangImg,
    requestTagBangbangList,
    requestTagBangbangSelf,
    requestTagBangbangSearch,
    requestTagBangbangDetail,
    requestTagBangbangCollect,
    requestTagBangbangDisCollect,
    requestTagBangbangClose,
    requestTagBangbangOpen,
    requestTagBangbangDeleteImg,
    requestTagBangbangCommentAdd,
    requestTagBangbangCommentAddImg,
    requestTagCreateXiaoyuantao,
    requestTagGetXiaoyuantaoList,
    requestTagGetXiaoyuantaoDetail,
    requestTagGetXiaoyuantaoClose,
    requestTagGetMyXiaoyuantao,
    requestTagGetJianzhiList,
    requestTagGetJianzhiDetail,
    requestTagGetJianzhiCollect,
    requestTagGetJianzhiDisCollect,
    requestTagGetResume,
    requestTagUpdateResume,
    
    //------xingql------
    requsetTagCancelActivitySponsor,
    requestTagGroupSendMessage,
    requestTagDownloadAdvertiseMentImage
    
} ;

typedef enum
{
    commentType,
    simpleType,
    
} pathType;


// 评论请求
#define bangbangComment  @"bangbangcomment"
#define jianzhiComment   @"positioncomment"
#define studentCard      @"studentCard"
#define memberCenter_bg  @"userCustomImg"


#define Heigth_ImageCell 110
#define Heigth_TextCell 105    //110
#define Heigth_SingleLineCell 87    //87
#define Heigth_Topic_ActivityCell 65

/**
 * @brief 图片缩放
 *
 * scaleToImage
 * @param[in] img 图片
 * @param[in] size 缩放的大小
 * @return UIImage 缩放后的图片
 * @note
 */
+ (UIImage*)scaleToImage:(UIImage*)img withSize:(CGSize)size;

/**
 * @brief
 *
 * Detailed comments of this function
 * @param[in]
 * @param[out]
 * @return
 * @note
 */
+(BOOL)isValidateEmail:(NSString *)email;

+ (BOOL)isMobileNumber:(NSString *)mobileNum;

+(BOOL) isCharacter:(unsigned short) character;

/**
 * @brief
 *
 * Detailed comments of this function
 * @param[in]
 * @param[out]
 * @return
 * @note
 */
+(NSString *)reverseStr:(NSString *)srcStr;

/**
 * @brief label长度
 *
 * @return cgsize label长度
 * @note
 */
+(CGFloat) getHeightWithStr:(NSString *)str withFontSize:(double) size withLabelWidth:(float) width;

+ (UIView *)setDisplayCustomTitleText:(NSString*)text;

// 处理手机号码
+(NSString *) formatPhoneNum: (NSString *)phoneNum;

// 图片修改头像
+ (UIImage *)saveImage:(UIImage *)image heightOfImageLayer:(float) height;

// 获取相册图片
+ (UIImage *)fullResolutionImageFromALAsset:(ALAsset *)asset;

+(NSString *) getSmallImagePathWithPath:(NSString *) oldPath;

+(NSString *) formatterDate:(NSString *)oldDate;

+(NSInteger) checkStrLength:(NSString *) str;


//对网络获取的数据处理成 85*60 的cell 图片
+(UIImage *) handleImageForTableViewCell:(UIImage *)image;



/*!
 * 重构cell的高度！
 */
+ (CGFloat)factorHeightForCellAtIndexPath:(NSIndexPath *)indexPath withMoreContentLinesData:(NSMutableArray *)data;


+ (CGFloat)factorHeightForCellAtIndexPath:(NSIndexPath *)indexPath
                            withFirstData:(NSMutableArray *)firstData
                           withSecondData:(NSMutableArray *)secondData;


+ (CGFloat)factorHeightForCellAtIndexPath:(NSIndexPath *)indexPath
                            withFirstData:(NSMutableArray *)firstData
                           withSecondData:(NSMutableArray *)secondData
                             withImageKey:(NSString *)imageKey;

+(NSString *) formatStrTrim:(NSString *) str ;

@end
