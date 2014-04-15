//
//  DoModel.h
//  Zuoye_music
//
//  Created by Ibokan on 14-4-14.
//  Copyright (c) 2014年 刘方强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DoModel : NSObject
{
  
    NSMutableArray * musicArray;//歌曲数组
//    NSMutableArray *timeArray;//时间数组
//    NSMutableDictionary * LRCDictionary;//歌词字典
    NSInteger lrcLineNumber;//歌词行数

}

+(id)initSingleModel;
-(NSDictionary *)LRCWithName:(NSString*)songName;
-(NSString * )timeWithIntival:(int )timer;
-(NSUInteger)changeTime:(NSString * )str;
@end
