//
//  ActivityTableViewCell.m
//  NTSociety
//
//  Created by retygu on 4/2/14.
//  Copyright (c) 2014 rety gu. All rights reserved.
//

#import "ActivityTableViewCell.h"
#import "UIViewExt.h"
#import "Common.h"

@implementation ActivityTableViewCell

@synthesize headerBgView;
@synthesize typeView;
@synthesize nameLabel;
@synthesize titleLabel;
@synthesize commentLabel;
@synthesize albumImageView;
@synthesize timeLabel;
@synthesize commentIconView;
@synthesize cellBottleView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        //tableview Cell BackgroundView
        headerBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];

        headerBgView.backgroundColor =  [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0f];

        [self addSubview:headerBgView];
        
        // 标题
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 306, 30)];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        
        self.titleLabel.numberOfLines = 1;
        
//        self.titleLabel.backgroundColor = [UIColor redColor];
        
        // Add as the nav bar's titleview
        [headerBgView addSubview:self.titleLabel];
//        [self.contentView addSubview:self.titleLabel];
        
        //---------xingql--------
        //content
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 300, 30)];
        self.contentLabel.backgroundColor = [UIColor clearColor];
        self.contentLabel.textColor = [UIColor blackColor];
        self.contentLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
        self.contentLabel.textAlignment = NSTextAlignmentLeft;
        self.contentLabel.textColor = [UIColor colorWithRed:140.0/255 green:140.0/255 blue:140.0/255 alpha:1.0];
        self.contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        [headerBgView addSubview:self.contentLabel];
        
        
        self.cellBottleView = [[UIView alloc] initWithFrame:CGRectMake(self.headerBgView.left+10, Heigth_SingleLineCell-25, self.headerBgView.width, 25)];
        
        self.typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 5, 26, 13)];
        self.typeLabel.font = [UIFont fontWithName:@"Helvetica" size:10];
        self.typeLabel.textColor = [UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:1.0f];
        self.typeLabel.textAlignment = NSTextAlignmentCenter;
        self.typeLabel.layer.borderWidth = 0.5;
        self.typeLabel.layer.borderColor = [UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:1.0].CGColor;
        [self.cellBottleView addSubview:self.typeLabel];
        
        // 姓名
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 2, 50, 20)];
        self.nameLabel.backgroundColor = [UIColor clearColor];
        self.nameLabel.textColor = [UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:1.0f];
        self.nameLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
        self.nameLabel.textAlignment = NSTextAlignmentLeft;
        [cellBottleView addSubview:nameLabel];
        
        
        // 时间
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 2, 80,20)];
        self.timeLabel.backgroundColor = [UIColor clearColor];
        self.timeLabel.textColor = [UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:1.0f];
        self.timeLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
        self.timeLabel.textAlignment = NSTextAlignmentLeft;
        // Add as the nav bar's titleview
        [cellBottleView addSubview:timeLabel];
        
        
        //话题
        commentIconView = [[UIImageView alloc] initWithFrame:CGRectMake(250, 4, 15, 15)];
        commentIconView.image = [UIImage imageNamed:@"commented222.png"];
        [cellBottleView addSubview:commentIconView];
        
        //话题数
        self.commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(272, 2, 30, 20)];
        self.commentLabel.backgroundColor = [UIColor clearColor];
        self.commentLabel.textColor = [UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:1.0f];
        self.commentLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
        self.commentLabel.textAlignment = NSTextAlignmentLeft;
        self.commentLabel.text = @"200";
        // Add as the nav bar's titleview
        [cellBottleView addSubview:commentLabel];
        
        [headerBgView addSubview:cellBottleView];
//        [self.contentView addSubview:cellBottleView];
        //如果带有图片
        self.albumImageView = [[UIImageView alloc] initWithFrame:CGRectMake(225, 12, 85 , 0)];
        self.albumImageView.backgroundColor = [UIColor colorWithRed:247/255.0f green:247/255.0f blue:247/255.0f alpha:1.0f];
        [headerBgView addSubview:self.albumImageView];
//        [self.contentView addSubview:self.albumImageView];
    }
    

    
//    self.selected = YES;
//    UIView *view = [[UIView alloc] init];
//    view.backgroundColor = [UIColor yellowColor];
//    self.selectedBackgroundView = view;
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//-(void) drawRect:(CGRect)rect {
//    CGContextRef ctx = UIGraphicsGetCurrentContext();//获取当前ctx
//    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
//    CGContextSetLineWidth(ctx, 0.8);  //线宽
//    CGContextSetAllowsAntialiasing(ctx, YES);
//    CGContextSetRGBStrokeColor(ctx, 195/255.0f, 195/255.0f, 195/255.0f, 1.0);  //颜色
//    CGContextBeginPath(ctx);
//    CGContextMoveToPoint(ctx, 10, 64);  //起点坐标
//    CGContextAddLineToPoint(ctx, 310, 64);   //终点坐标
//    CGContextStrokePath(ctx);
//}

@end
