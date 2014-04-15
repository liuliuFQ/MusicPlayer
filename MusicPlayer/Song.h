//
//  Song.h
//  Zuoye_music
//
//  Created by Ibokan on 14-3-14.
//  Copyright (c) 2014年 刘方强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Song : NSObject
@property(nonatomic,strong)NSString * name;
@property(nonatomic,strong)NSString * type;
-(id)initWithName:(NSString * )theName type:(NSString * )theType;
@end
