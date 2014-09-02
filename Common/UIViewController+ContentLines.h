//
//  UIViewController+ContentLines.h
//  NTSociety
//
//  Created by 邢奇隆 on 14-6-10.
//  Copyright (c) 2014年 rety gu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ContentLines)


/*!
 *  该方法用于判断cell中content的长度，从而判断是否需要多行显示，最后存储到字典保存到数组中输出！默认content、image字段为：@"dynamicContent" @"dynamicImg"。
 */
- (NSMutableArray *)contentLinesFromServerData:(NSMutableArray *)data;

/*!
 *  该方法用于判断cell中content的长度，从而判断是否需要多行显示，最后存储到字典保存到数组中输出！需要指定content，image key字段。
 */
- (NSMutableArray *)contentLinesFromServerData:(NSMutableArray *)data
                                withContentKey:(NSString *)contentKey
                                  withImageKey:(NSString *)imageKey;

@end
