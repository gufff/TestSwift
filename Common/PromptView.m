//
//  PromptView.m
//  NTSociety
//
//  Created by retygu on 4/9/14.
//  Copyright (c) 2014 rety gu. All rights reserved.
//

#import "PromptView.h"
//#import "AppDelegate.h"
#import "Common.h"

static PromptView* _promptView = nil;

@implementation PromptView

@synthesize titleLabel;

+ (id)defaultPromptView {
    
    if (_promptView == nil) {
        _promptView = [[PromptView alloc] init];
    }
    return _promptView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = [ UIScreen mainScreen ].bounds;
        // Initialization code
        titleLabel = [[UILabel alloc] initWithFrame:self.frame];
        titleLabel.layer.cornerRadius = 8.0f;
        titleLabel.layer.masksToBounds = YES;
        titleLabel.backgroundColor = [UIColor blackColor];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
        titleLabel.numberOfLines = 0;
        titleLabel.alpha = 0.8;
        titleLabel.center = self.center;
        titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        // Add as the nav bar's titleview
        [self addSubview:titleLabel];
    }
    return self;
}

//-(void) showPromptWithText:(NSString *)text {
//    titleLabel.text = text;
//    CGFloat contentHeight = [Common getHeightWithStr:text withFontSize:13 withLabelWidth:160];
//    if (contentHeight < 100) {
//        contentHeight = 100;
//    }
//    titleLabel.frame = CGRectMake(80, (self.frame.size.height - contentHeight) / 2, 160, contentHeight);
//    
//    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    UIWindow *window = app.window;
//    [window addSubview:self];
//    timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(closeView) userInfo:nil repeats:NO];
//}
//
-(void) closeView {
    [self removeFromSuperview];
    [timer invalidate];
}

@end
