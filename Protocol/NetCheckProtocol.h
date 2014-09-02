//
//  NetCheckProtocol.h
//  NationalFitness
//
//  Created by rety gu on 13-3-18.
//  Copyright (c) 2013年 rety gu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NetCheckProtocol <NSObject>

@optional

- (void)netcheckFail:(NSString *) failData withTag:(NSInteger) tag;

@end