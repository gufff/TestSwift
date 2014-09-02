//
//  NoneView.h
//  NTSociety
//
//  Created by retygu on 4/24/14.
//  Copyright (c) 2014 rety gu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoneView : UIView

@property (nonatomic, strong) UIImageView *defaultImageView;
@property (nonatomic, strong) UILabel *defaultLabel;


-(void) showWithText:(NSString *) text;

@end
