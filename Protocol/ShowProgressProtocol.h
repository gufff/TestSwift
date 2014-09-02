//
//  NetCheckProtocol.h
//  NationalFitness
//
//  Created by rety gu on 13-3-18.
//  Copyright (c) 2013年 rety gu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ShowProgressProtocol <NSObject>

@optional

- (void)showProgress:(float) progress;

- (void) uploadSuccess :(NSDictionary *) dataDic;;

-(void) uploadFailed;

@end