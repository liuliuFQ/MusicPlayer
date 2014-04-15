//
//  MusicViewController.h
//  Zuoye_music
//
//  Created by Ibokan on 14-3-14.
//  Copyright (c) 2014年 刘方强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "Song.h"
#define kRGBA( r, g, b, a) [UIColor colorWithRed:r green:g blue:b alpha:a]
#define kFontSize(s) [UIFont systemFontOfSize:s]


@interface MusicViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    AVAudioPlayer * audioPlayer;//音乐播放器
    NSMutableArray * musicArray;//歌曲数组
    BOOL isPlay;//是否播放
    BOOL isCircle;//是否循环
    Song * currentMusic;//当前播放的音乐
    NSMutableArray *timeArray;//时间数组
    NSMutableDictionary * LRCDictionary;//歌词字典
    NSInteger lrcLineNumber;//歌词行数
    NSInteger musicArrayNumber;//歌曲数组索引

}
@property (strong, nonatomic) IBOutlet UILabel *currentLabel;
@property (strong, nonatomic) IBOutlet UILabel *totalLabel;


@property (strong, nonatomic) IBOutlet UIButton *playButton;
- (IBAction)play:(id)sender;


- (IBAction)aboveButton:(id)sender;
- (IBAction)nextButton:(id)sender;

@property (strong, nonatomic) IBOutlet UISlider *slider;
- (IBAction)sliderChanged:(id)sender;

@property (strong, nonatomic) IBOutlet UITableView *tableView;


@end
