//
//  DoModel.h
//  Zuoye_music
//
//  Created by Ibokan on 14-4-14.
//  Copyright (c) 2014年 刘方强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DoModel : NSObject

+(id)initSingleModel;
-(NSDictionary *)LRCWithName:(NSString*)songName;
-(NSString * )timeWithIntival:(int )timer;
-(NSUInteger)changeTime:(NSString * )str;
@end
