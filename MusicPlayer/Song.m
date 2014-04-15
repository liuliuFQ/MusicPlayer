//
//  Song.m
//  Zuoye_music
//
//  Created by Ibokan on 14-3-14.
//  Copyright (c) 2014年 刘方强. All rights reserved.
//

#import "Song.h"

@implementation Song
-(id)initWithName:(NSString * )theName type:(NSString * )theType;
{
    self = [super init];
    if (self) {
        self.name = theName;
        self.type = theType;
    }

    return self;
}
@end
