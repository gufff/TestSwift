//
//  UIViewController+ContentLines.m
//  NTSociety
//
//  Created by 邢奇隆 on 14-6-10.
//  Copyright (c) 2014年 rety gu. All rights reserved.
//

#import "UIViewController+ContentLines.h"

@implementation UIViewController (ContentLines)


/**
 *  将原始数据进行加工，判断数据的长度，添加换行标志位，从而来确定是否需要换行；
 */
- (NSMutableArray *)contentLinesFromServerData:(NSMutableArray *)data {
    NSMutableArray *moreContentLinesFlags = [NSMutableArray new];
    //根据获取的hotInfoArray判断content的行数
    for (int i=0; i<data.count; i++) {
        
        NSDictionary *dic = data[i];
        NSString *contentStr = [dic objectForKey:@"dynamicContent"];
        NSString *imageStr = [dic objectForKey:@"dynamicImg"];
        
        //没有图片
        if ([imageStr isEqualToString:@""]) {
            CGSize size = [self getStringRect:contentStr withSize:CGSizeMake(300, 1000)];
            
            if (size.height > 17) {  //临界为16.1，即被视为多于一行......
                NSDictionary *newDic = [NSDictionary dictionaryWithObjects:@[[NSNumber numberWithInt:i],contentStr,@"yes",imageStr] forKeys:@[@"index",@"dynamicContent",@"flag",@"dynamicImg"]];
                
                [moreContentLinesFlags addObject:newDic];
                
            } else {
                NSDictionary *newDic = [NSDictionary dictionaryWithObjects:@[[NSNumber numberWithInt:i],contentStr,@"no",imageStr] forKeys:@[@"index",@"dynamicContent",@"flag",@"dynamicImg"]];
                [moreContentLinesFlags addObject:newDic];
            }
        } else {
            CGSize size = [self getStringRect:contentStr withSize:CGSizeMake(200, 1000)];
            
            if (size.height > 17) {
                //两行contnet
                NSDictionary *newDic = [NSDictionary dictionaryWithObjects:@[[NSNumber numberWithInt:i],contentStr,@"yes",imageStr] forKeys:@[@"index",@"dynamicContent",@"flag",@"dynamicImg"]];
                [moreContentLinesFlags addObject:newDic];
            } else {
                //一行content
                NSDictionary *newDic = [NSDictionary dictionaryWithObjects:@[[NSNumber numberWithInt:i],contentStr,@"no",imageStr] forKeys:@[@"index",@"dynamicContent",@"flag",@"dynamicImg"]];
                [moreContentLinesFlags addObject:newDic];

            }

        } //有图片
    }
    
    return moreContentLinesFlags;
}



- (NSMutableArray *)contentLinesFromServerData:(NSMutableArray *)data
                                withContentKey:(NSString *)contentKey
                                  withImageKey:(NSString *)imageKey {
    NSMutableArray *moreContentLinesFlags = [NSMutableArray new];
    //根据获取的hotInfoArray判断content的行数
    for (int i=0; i<data.count; i++) {
        
        NSDictionary *dic = data[i];
        NSString *contentStr = [dic objectForKey:contentKey];
        NSString *imageStr = [dic objectForKey:imageKey];
        NSUInteger length = [contentStr length];
        //没有图片
        if ([imageStr isEqualToString:@""]) {
            if (length > 19) {
                NSDictionary *newDic = [NSDictionary dictionaryWithObjects:@[[NSNumber numberWithInt:i],contentStr,@"yes",imageStr] forKeys:@[@"index",@"dynamicContent",@"flag",@"dynamicImg"]];
                
                [moreContentLinesFlags addObject:newDic];
            } else {
                NSDictionary *newDic = [NSDictionary dictionaryWithObjects:@[[NSNumber numberWithInt:i],contentStr,@"no",imageStr] forKeys:@[@"index",@"dynamicContent",@"flag",@"dynamicImg"]];
                [moreContentLinesFlags addObject:newDic];
            }
        } else {
            
            if (length > 13) {
                //两行contnet
                NSDictionary *newDic = [NSDictionary dictionaryWithObjects:@[[NSNumber numberWithInt:i],contentStr,@"yes",imageStr] forKeys:@[@"index",@"dynamicContent",@"flag",@"dynamicImg"]];
                [moreContentLinesFlags addObject:newDic];
            } else {
                //一行content
                NSDictionary *newDic = [NSDictionary dictionaryWithObjects:@[[NSNumber numberWithInt:i],contentStr,@"no",imageStr] forKeys:@[@"index",@"dynamicContent",@"flag",@"dynamicImg"]];
                [moreContentLinesFlags addObject:newDic];
                
            }
            
        } //有图片
    }
    
    return moreContentLinesFlags;
}

//  For iOS7
- (CGSize)getStringRect:(NSString*)aString withSize:(CGSize)originSize {
    
    CGSize size;
//    NSDictionary *dic = @{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:14]};

//    size = [aString boundingRectWithSize:originSize
//                                 options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
//                              attributes:dic
//                                 context:nil].size;
    
    size = [aString drawInRect:CGRectMake(0, 0, originSize.width,  originSize.height) withFont:[UIFont fontWithName:@"Helvetica" size:14]  lineBreakMode:NSLineBreakByWordWrapping];
    return  size;
}



/*
//  获取字符串的大小  iOS6
- (CGSize)getStringRect_:(NSString*)aString {
    
    CGSize size;
 
    UIFont *nameFont=[UIFont fontWithName:@"Helvetica" size:14];
    
    size=[aString sizeWithFont:nameFont constrainedToSize:CGSizeMake(200, 1000) lineBreakMode:NSLineBreakByCharWrapping];
    
    return  size;
}
 */

@end
