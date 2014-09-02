//
//  DataLoadProtocol.h
//  NationalFitness
//
//  Created by rety gu on 13-3-18.
//  Copyright (c) 2013年 rety gu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DataLoadProtocol <NSObject>

//@optional
-(void) dataLoadSuccess :(NSDictionary *) dataDic withTag:(NSInteger) tag;

-(void) dataLoadFail :(NSString *) errMessage withTag:(NSInteger) tag;

@end
