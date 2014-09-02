//
//  NoneView.m
//  NTSociety
//
//  Created by retygu on 4/24/14.
//  Copyright (c) 2014 rety gu. All rights reserved.
//

#import "NoneView.h"

@implementation NoneView

@synthesize defaultImageView;
@synthesize defaultLabel;



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        defaultImageView = [[UIImageView alloc] initWithFrame:CGRectMake(80, 10, 157, 221)];
        defaultImageView.image = [UIImage imageNamed:@"noneDefault.png"];
        [self addSubview:defaultImageView];
        
        defaultLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 240, 220, 40)];
        defaultLabel.textAlignment = NSTextAlignmentCenter;
        defaultLabel.numberOfLines = 0;
        defaultLabel.lineBreakMode = NSLineBreakByCharWrapping;
        defaultLabel.textColor = [UIColor colorWithRed:153/255.0f green:153/255.0f blue:153/255.0f alpha:1.0f];
        defaultLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
        [self addSubview:defaultLabel];
    }
    return self;
}

-(void) showWithText:(NSString *) text {
    self.defaultLabel.text = text;
}


@end
