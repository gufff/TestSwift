//
//  MainInfomationUITableViewCell.m
//  NTSociety
//
//  Created by retygu on 4/2/14.
//  Copyright (c) 2014 rety gu. All rights reserved.
//

#import "MainInfomationUITableViewCell.h"

@implementation MainInfomationUITableViewCell

@synthesize timeLabel;
@synthesize itemLabel;
@synthesize titleLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
//        self.backgroundColor = [UIColor clearColor];
        
        self.backgroundColor = [UIColor whiteColor];
        self.itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 14, 40, 16)];
        self.itemLabel.backgroundColor = [UIColor clearColor];
        self.itemLabel.layer.borderWidth = 0.5f;
        self.itemLabel.layer.borderColor = [UIColor colorWithRed:97/255.0f green:193/255.0f blue:190/255.0f alpha:1.0f].CGColor;
        self.itemLabel.font = [UIFont systemFontOfSize:11.0];
        self.itemLabel.textAlignment = NSTextAlignmentCenter;
        self.itemLabel.textColor = [UIColor colorWithRed:97/255.0f green:193/255.0f blue:190/255.0f alpha:1.0f];
        [self addSubview:self.itemLabel];
        // 标题
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(56, 0, 190, self.frame.size.height)];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.font = [UIFont systemFontOfSize:13.0];
        
        [self addSubview:self.titleLabel];
        // 时间
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(249, 0, 60, self.frame.size.height)];
        self.timeLabel.backgroundColor = [UIColor clearColor];
        self.timeLabel.font = [UIFont systemFontOfSize:11.0];
        self.timeLabel.textColor = [UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:1.0f];
        [self addSubview:self.timeLabel];
        

    }
    return self;
}

//-(void) drawRect:(CGRect)rect {
//    CGContextRef ctx = UIGraphicsGetCurrentContext();//获取当前ctx
//    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
//    CGContextSetLineWidth(ctx, 0.5);  //线宽
//    CGContextSetAllowsAntialiasing(ctx, YES);
//    CGContextSetRGBStrokeColor(ctx, 195/255.0f, 195/255.0f, 195/255.0f, 1.0);  //颜色
//    CGContextBeginPath(ctx);
//    CGContextMoveToPoint(ctx, 10, 44);  //起点坐标
//    CGContextAddLineToPoint(ctx, 310, 44);   //终点坐标
//    CGContextStrokePath(ctx);
//}
@end
