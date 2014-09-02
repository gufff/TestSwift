//
//  Engine.h
//  yunliTextiles
//
//  Created by rety gu on 13-3-18.
//  Copyright (c) 2013年 rety gu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"
#import "ASIFormDataRequest.h"
#import "Common.h"
#import "ShowProgressProtocol.h"
#import <UIKit/UIKit.h>

@protocol NetCheckProtocol;
@protocol ImageLoadProtocol;
@protocol DataLoadProtocol;
@protocol ShowProgressProtocol;

@interface Engine : NSObject

@property(nonatomic, assign, setter = setimagepl:) id<ImageLoadProtocol> imagepl;
@property(nonatomic, assign, setter = setnetpl:) id<NetCheckProtocol> netpl;
@property(nonatomic, assign, setter = setdatapl:) id<DataLoadProtocol> datapl;
@property (nonatomic, assign, setter = setprogresspl:) id<ShowProgressProtocol> progresspl;

@property(nonatomic, retain) ASIHTTPRequest *asyncRequest;
@property(nonatomic, retain) ASINetworkQueue *networkqueue;
@property(nonatomic, retain) ASINetworkQueue *uploadNetworkqueue;
/**
 * @brief
 *
 * Detailed comments of this function
 * @param[in]
 * @param[out]
 * @return
 * @note
 */
+ (id)defaultEngine;

/**
 * @brief Asynchronous Request
 *
 * 异步请求
 * @param[in]
 * @param[out]
 * @return
 * @note
 */
-(void)asynchronousRequestWithUrl:(NSString *)url  withTag:(NSInteger) tag;

-(void)synchronousRequestWithUrl:(NSString *)url  withTag:(NSInteger) tag;

/**
 * @brief downloadImage
 *
 * Detailed comments of this function
 * @param[in] url：图片地址 localName：图片本地存储名
 * @param[out]
 * @return
 * @note
 */
-(void)downloadImage:(NSString *)url withLocalName:(NSString *)localName withRequestTag:(NSInteger) tag;

-(void)cancelAsynchronousRequest;

-(void)cancelDownloadImages;

- (void)uploadPhotoWithUrl:(NSString *)url withDataDic :(NSDictionary *)dataDic withTag:(NSInteger) tag;

-(void)uploadImage:(NSString *)url withDataDic:(NSDictionary *)dataDic;

@end
