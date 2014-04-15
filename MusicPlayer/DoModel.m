//
//  DoModel.m
//  Zuoye_music
//
//  Created by Ibokan on 14-4-14.
//  Copyright (c) 2014年 刘方强. All rights reserved.
//

#import "DoModel.h"

@implementation DoModel
+(id)initSingleModel{
   static DoModel * doModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        doModel = [[DoModel alloc]init];
    });
    return doModel;
}
-(NSDictionary *)LRCWithName:(NSString*)songName{
    NSMutableArray *timeArray = [NSMutableArray array];//时间数组
    NSMutableDictionary * LRCDictionary  = [NSMutableDictionary dictionary];//歌词字典
    NSString * contentStr = [NSString stringWithContentsOfFile:songName encoding:NSUTF8StringEncoding error:nil];
    NSArray * array = [contentStr componentsSeparatedByString:@"\n"];
    int num = [array count];
    
    for (int i = 0; i< num ; i++) {
        NSString * linStr = [array objectAtIndex:i];//获得一行歌词[00:02.07]偶阵雨 - 梁静茹
        NSArray * lineArray = [linStr componentsSeparatedByString:@"]"];//时间分离[00:02.07
        if ([lineArray[0] length]>8) {
            NSString * str1 = [linStr substringWithRange:NSMakeRange(3, 1)];
            NSString * str2 = [linStr substringWithRange:NSMakeRange(6, 1)];
            if ([str1 isEqualToString:@":"]&&[str2 isEqualToString:@"."]) {
                NSString * lrcStr = [lineArray objectAtIndex:1];//清除时间后的歌词
                NSString * timeStr = [[lineArray objectAtIndex:0]substringWithRange:NSMakeRange(1, 5)];//时间
                [LRCDictionary setObject:lrcStr forKey:timeStr];//以每行时间为键将歌词加入数组
                [timeArray addObject:timeStr];//事件列表,timeArray的count就是行数
                
            }
        }
    }
    NSDictionary * dic =@{@"LRCDictionary": LRCDictionary,@"timeArray":timeArray};
    return dic;
    dlog();



}
-(NSString * )timeWithIntival:(int )timer{
    if (timer % 60 < 10) {//播放时间秒在10之内
       return  [NSString stringWithFormat:@"%d:0%d",timer/ 60,timer % 60];
    }
    
    else{
        return  [NSString stringWithFormat:@"%d:%d",timer / 60,timer % 60];
        
    }


}
-(NSUInteger)changeTime:(NSString * )str{
    NSArray * array = [str componentsSeparatedByString:@":"];
    return  [array[0] intValue]* 60 + [array[1] intValue];

}
@end
