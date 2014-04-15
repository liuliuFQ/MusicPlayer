//
//  MyCell.m
//  Zuoye_music
//
//  Created by Ibokan on 14-4-14.
//  Copyright (c) 2014年 刘方强. All rights reserved.
//

#import "MyCell.h"

@implementation MyCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    //无选中模式
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];//不要颜色
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
