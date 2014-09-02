//
//  PromptView.h
//  NTSociety
//
//  Created by retygu on 4/9/14.
//  Copyright (c) 2014 rety gu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PromptView : UIView
{
    NSTimer *timer;
}

@property (nonatomic, strong) UILabel *titleLabel;

+ (id)defaultPromptView;

-(void) showPromptWithText:(NSString *) text;

@end
