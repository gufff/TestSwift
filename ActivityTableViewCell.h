//
//  ActivityTableViewCell.h
//  NTSociety
//
//  Created by retygu on 4/2/14.
//  Copyright (c) 2014 rety gu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *typeView;

@property (nonatomic, strong) UILabel *typeLabel;

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *albumImageView;
@property (nonatomic, strong) UILabel *commentLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *commentIconView;
@property (nonatomic, strong) UIView *headerBgView;

//----------xingql---------
@property (nonatomic, strong) UILabel *contentLabel;


@property (nonatomic, strong) UIView *cellBottleView;    //用于存放姓名、时间、评论的容器

@end
