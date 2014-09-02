//
//  Common.m
//  yunliTextiles
//
//  Created by rety gu on 13-3-18.
//  Copyright (c) 2013年 rety gu. All rights reserved.
//


#define LINE_BORDER_WIDTH 1.0


#import "Common.h"

//#import "UIImage+KIAdditions.h"

@implementation Common

/**
 * @brief 图片缩放
 *
 * scaleToImage
 * @param[in] img 图片
 * @param[in] size 缩放的大小
 * @return UIImage 缩放后的图片
 * @note
 */
+ (UIImage*)scaleToImage:(UIImage*)img withSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    return newImage;
}

/**
 * @brief
 *
 * Detailed comments of this function
 * @param[in]
 * @param[out]
 * @return
 * @note
 */
+(BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
/**
 * @brief
 *
 * Detailed comments of this function
 * @param[in]
 * @param[out]
 * @return
 * @note
 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
//    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
//    /**
//     10         * 中国移动：China Mobile
//     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
//     12         */
//    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
//    /**
//     15         * 中国联通：China Unicom
//     16         * 130,131,132,152,155,156,185,186
//     17         */
//    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,181,189
     22         */
    NSString * CT = @"^1([3-8])\\d{9}$";

    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
//    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
//    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
//    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
//        || ([regextestcm evaluateWithObject:mobileNum] == YES)
//        || ([regextestct evaluateWithObject:mobileNum] == YES)
//        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    
    if (([regextestct evaluateWithObject:mobileNum] == YES)) {
        return YES;
    }
    else
    {
        return NO;
    }
}

+(BOOL) isCharacter:(unsigned short) character {
    NSString * CT = @"^[A-Za-z]+$";
    
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestct evaluateWithObject:[NSString stringWithFormat:@"%c", character]] == YES)) {
        return YES;
    }
    else
    {
        return NO;
    }
}

/**
 * @brief
 *
 * Detailed comments of this function
 * @param[in]
 * @param[out]
 * @return
 * @note
 */
+(NSString *)reverseStr:(NSString *)srcStr {
    NSString *desSrc = nil;
    NSInteger len = [srcStr length];
    
    //字符串反转
    NSMutableString *strs = [NSMutableString stringWithCapacity:len];
    while (len > 0) {
        unichar c = [srcStr characterAtIndex:--len];
        desSrc = [NSString stringWithFormat:@"%C",c];
        [strs appendString:desSrc];
    }
    
    NSInteger len2 = [strs length];
    NSString *desSrc2 = nil;
    NSMutableString *strs2 = [NSMutableString stringWithCapacity:len2];
    
    //字符asicii码转换
    unichar d;
    for (int i=0; i<len2; i++) {
        d = [strs characterAtIndex:i];
        if (d == 36) {
            d = 124;
        } else if (d == 42) {
            d = 46;
        }
        else {
            d = d - 50;
        }
        
        desSrc2 = [NSString stringWithFormat:@"%C",d];
        [strs2 appendString:desSrc2];
        
    }
    
    return strs2;
}

/**
 * @brief label长度
 *
 * @return cgsize label长度
 * @note
 */
+(CGFloat) getHeightWithStr:(NSString *)str withFontSize:(double) size withLabelWidth:(float)width {
    if (str) {
        // 计算文本的大小
        CGSize textSize;
        
        if (sys_version_ForiOS7) {
        NSDictionary *stringAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:size]};
        // 计算文本的大小
        textSize = [str boundingRectWithSize:CGSizeMake(width, 10000) // 用于计算文本绘制时占据的矩形块
                                            options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading // 文本绘制时的附加选项
                                         attributes:stringAttributes        // 文字的属性
                                            context:nil].size;
        }
        else {
            textSize = [str drawInRect:CGRectMake(0, 0, width, 1000) withFont:[UIFont systemFontOfSize:size]  lineBreakMode:NSLineBreakByWordWrapping];
        }
        
        int height = textSize.height;
        int finalHeight = ( height + 10 ) > 40.0f ? ( height + 10) : 40.0f;
        return finalHeight;
    } else {
        return 0;
    };
}



+ (UIView *)setDisplayCustomTitleText:(NSString*)text
{
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 160, 44)];
    titleView.autoresizesSubviews = YES;
    titleView.backgroundColor = [UIColor clearColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    //表示行数
    titleLabel.numberOfLines = 0;
    titleLabel.text = text;
    // Add as the nav bar's titleview
    [titleView addSubview:titleLabel];
    return titleView;
    
}


// 处理手机号码
+(NSString *) formatPhoneNum: (NSString *)phoneNum {
    NSString *newPhone = [NSString stringWithString:phoneNum];
    NSRange foundObj=[newPhone rangeOfString:@"+86" options:NSCaseInsensitiveSearch];
    if (foundObj.length > 0) {
        newPhone = [newPhone stringByReplacingCharactersInRange:foundObj withString:@""];
    }
    NSRange foundObj2=[newPhone rangeOfString:@"-" options:NSCaseInsensitiveSearch];
    if (foundObj2.length > 0) {
        newPhone = [newPhone stringByReplacingCharactersInRange:foundObj2 withString:@""];
    }
    NSRange foundObj3=[newPhone rangeOfString:@"-" options:NSCaseInsensitiveSearch];
    if (foundObj3.length > 0) {
        newPhone = [newPhone stringByReplacingCharactersInRange:foundObj3 withString:@""];
    }
        return newPhone;
}


+ (UIImage *)fullResolutionImageFromALAsset:(ALAsset *)asset {
    
    ALAssetRepresentation *assetRep = [asset defaultRepresentation];
    CGImageRef imgRef = [assetRep fullResolutionImage];
    UIImage *img = [UIImage imageWithCGImage:imgRef
                                       scale:assetRep.scale
                                 orientation:(UIImageOrientation)assetRep.orientation];
    return img;
}

+ (UIImage *)saveImage:(UIImage *)image heightOfImageLayer:(float) height {
    UIImage *finalImage = nil;
    CGRect rect;
    rect.size = CGSizeMake(height, height);
    rect.origin = CGPointMake(0, 0);
    float _pathWidth = 1.0f;
    CGRect rectImage = rect;
    rectImage.origin.x += _pathWidth;
    rectImage.origin.y += _pathWidth;
    rectImage.size.width -= _pathWidth*2.0;
    rectImage.size.height -= _pathWidth*2.0;
    
    UIGraphicsBeginImageContextWithOptions(rect.size,0,0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();

    CGContextAddEllipseInRect(ctx, rect);
    CGContextClip(ctx);
    [image drawInRect:rectImage];
    //Add intern and extern line
    rectImage.origin.x -= LINE_BORDER_WIDTH/2.0;
    rectImage.origin.y -= LINE_BORDER_WIDTH/2.0;
    rectImage.size.width += LINE_BORDER_WIDTH;
    rectImage.size.height += LINE_BORDER_WIDTH;
    
    rect.origin.x += LINE_BORDER_WIDTH/2.0;
    rect.origin.y += LINE_BORDER_WIDTH/2.0;
    rect.size.width -= LINE_BORDER_WIDTH;
    rect.size.height -= LINE_BORDER_WIDTH;
    
    CGContextSetStrokeColorWithColor(ctx, [[UIColor colorWithRed:195/255.0f green:195/255.0f blue:195/255.0f alpha:1.0f] CGColor]);
    CGContextSetLineWidth(ctx, LINE_BORDER_WIDTH);
    CGContextStrokeEllipseInRect(ctx, rectImage);
    CGContextStrokeEllipseInRect(ctx, rect);
    finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return finalImage;
    
}

+(NSString *) getSmallImagePathWithPath:(NSString *) oldPath {
    NSArray *arr = [oldPath componentsSeparatedByString:@"."];
    NSString *smallPath = [NSString stringWithFormat:@"%@_small.%@", arr[0], arr[1]];
    return smallPath;
}

+(NSString *) formatterDate:(NSString *)oldDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[formatter dateFromString:oldDate];
    [formatter setDateFormat:@"yyyy"];
    NSString *destDateString = [formatter stringFromDate:date];
    
    NSDate *nowDate = [NSDate date];
    NSString *nowYear = [formatter stringFromDate:nowDate];
    if ([destDateString isEqualToString:nowYear]) {
        // 是本年
        [formatter setDateFormat:@"MM"];
        NSString *nowMonth = [formatter stringFromDate:nowDate];
        if ([nowMonth isEqualToString:[formatter stringFromDate:date]]) {
            // 是本月
            [formatter setDateFormat:@"MM-dd HH:mm"];
            destDateString = [formatter stringFromDate:date];
        } else {
            [formatter setDateFormat:@"MM-dd"];
            destDateString = [formatter stringFromDate:date];
        }
    } else {
        [formatter setDateFormat:@"yyyy-MM-dd"];
        destDateString = [formatter stringFromDate:date];
    }
    return destDateString;
}

+(NSInteger) checkStrLength:(NSString *) str {
    NSInteger length = 0;
    for(int i = 0; i < [str length]; i++) {
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
            length++;
    }
    return length;
}


//------------xingql-------------
+(UIImage *) handleImageForTableViewCell:(UIImage *)image {
    //对原图压缩
    float H = (float)image.size.height;
    float W = (float)image.size.width;
    float scale = H / (double)W;                   //缩放比例
    //竖
    if (scale > 1 || scale == 1 ) {

        //缩放后的图片
        image = [Common scaleToImage:image withSize:CGSizeMake(85*2, 85*2*scale)];
  
        //截取后的图片
//        image = [image cropImageWithX:0 y:(image.size.height-60*2)/2 width:85*2 height:60*2];
    }
    else {
        image = [Common scaleToImage:image withSize:CGSizeMake(60,60/scale)];
//        image = [image cropImageWithX:(image.size.width-85)/2 y:0 width:85 height:60];
        
    }//横
    
    return image;
}

+ (CGFloat)factorHeightForCellAtIndexPath:(NSIndexPath *)indexPath withMoreContentLinesData:(NSMutableArray *)data {
    //带有图片的cell高度
    if (![[data[indexPath.row] objectForKey:@"dynamicImg"] isEqualToString:@""]) {
        return Heigth_ImageCell;
    }
    //不带图片
    else {
        NSDictionary *dic = data[indexPath.row];
        NSString *isMoreLines = [dic objectForKey:@"flag"];
        
        //多行contnet
        if ([isMoreLines isEqualToString:@"yes"]) {
            return Heigth_TextCell;
        } else {
            return Heigth_SingleLineCell;
        }
    }
    
}

/*!
 * 判断tableViewCell的高度。
 */
+ (CGFloat)factorHeightForCellAtIndexPath:(NSIndexPath *)indexPath withFirstData:(NSMutableArray *)firstData withSecondData:(NSMutableArray *)secondData {
    //带有图片的cell高度
    if (![[secondData[indexPath.row] objectForKey:@"dynamicImg"] isEqualToString:@""]) {
        return Heigth_ImageCell;
    }
    //不带图片
    else {
        NSDictionary *dic = secondData[indexPath.row];
        NSString *isMoreLines = [dic objectForKey:@"flag"];
        
        //多行contnet
        if ([isMoreLines isEqualToString:@"yes"]) {
            return Heigth_TextCell;
        } else {
            return Heigth_SingleLineCell;
        }
    }
    
}

+ (CGFloat)factorHeightForCellAtIndexPath:(NSIndexPath *)indexPath
                            withFirstData:(NSMutableArray *)firstData
                           withSecondData:(NSMutableArray *)secondData
                             withImageKey:(NSString *)imageKey {
    //带有图片的cell高度
    if (![[firstData[indexPath.row] objectForKey:imageKey] isEqualToString:@""]) {
        return Heigth_ImageCell;
    }
    //不带图片
    else {
        NSDictionary *dic = secondData[indexPath.row];
        NSString *isMoreLines = [dic objectForKey:@"flag"];
        
        //多行contnet
        if ([isMoreLines isEqualToString:@"yes"]) {
            return Heigth_TextCell;
        } else {
            return Heigth_SingleLineCell;
        }
    }
}

+(NSString *) formatStrTrim:(NSString *) str {
    return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end
