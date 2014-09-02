//
//  ImageLoadProtocol.h
//  NationalFitness
//
//  Created by rety gu on 13-3-18.
//  Copyright (c) 2013年 rety gu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ImageLoadProtocol <NSObject>

@optional

-(void) refreshImageWithTag:(NSInteger) requestTag;

@end
