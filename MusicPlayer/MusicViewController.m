//
//  MusicViewController.m
//  Zuoye_music
//
//  Created by Ibokan on 14-3-14.
//  Copyright (c) 2014年 刘方强. All rights reserved.
//

#import "MusicViewController.h"
//#import "DXSemiViewController.h"
//#import "DXSemiViewControllerCategory.h"
#import "MyCell.h"
#import "DoModel.h"

@interface MusicViewController ()

@end

@implementation MusicViewController

- (void)viewDidLoad

{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = NO;//消除cell间隔的横线
    [self userDefault];
        [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(showTime) userInfo:nil repeats:YES];
    dlog();

}
#pragma mark--默认值的设置
-(void)userDefault{

    isPlay = YES;
    isCircle = YES;
    lrcLineNumber = 0;
  
    [self initData];
    musicArrayNumber = 0;
   
    NSString * path = [[NSBundle mainBundle]pathForResource:@"梁静茹-偶阵雨" ofType:@"mp3"];
    NSURL * url = [NSURL fileURLWithPath:path];
    audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url  error:nil];
    audioPlayer.volume = 0.5f;
    [audioPlayer prepareToPlay];
 
    timeArray = [NSMutableArray array];
    LRCDictionary = [NSMutableDictionary dictionary];
 
    [_slider setThumbImage:[UIImage imageNamed:@"sliderThumb_small.png"] forState:UIControlStateNormal];
    [self initLRC];//初始化歌词

    
    


}

#pragma mark--初始化歌曲
-(void)initData;{
 
    Song * music1 = [[Song alloc]initWithName:@"梁静茹-偶阵雨" type:@"mp3"];
    musicArray = [NSMutableArray array];
    [musicArray addObject:music1];
     dlog();
}
#pragma mark--初始化歌词
-(void)initLRC{
    NSString * pathLRC = [[NSBundle mainBundle]pathForResource:[musicArray[musicArrayNumber] name] ofType:@"lrc"];
    
    DoModel * mo = [DoModel initSingleModel];
    NSDictionary * dic = [mo LRCWithName:pathLRC];
    LRCDictionary = [NSMutableDictionary dictionaryWithDictionary:[dic  objectForKey:@"LRCDictionary"]];
    
    timeArray = [NSMutableArray arrayWithArray:[dic objectForKey:@"timeArray"]];
    dlog();

}
#pragma mark---每隔0.1秒调用一次更新页面
-(void)showTime{
    
    DoModel * mo = [DoModel initSingleModel];
    _currentLabel.text = [mo timeWithIntival:(int)audioPlayer.currentTime];
    _totalLabel.text = [mo timeWithIntival:(int)audioPlayer.duration];
    
    [self displayWord];
    _slider.value = audioPlayer.currentTime / audioPlayer.duration;
    if ( audioPlayer.duration - audioPlayer.currentTime < 0.1  ) {//结束之后转换图片从头开始
        [_playButton setBackgroundImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
        
        isPlay = YES;
    }
}
#pragma mark ---显示唱到的那一句
-(void)displayWord{
    DoModel * mo = [DoModel initSingleModel];
    int num =[timeArray count ];
    for (int i = 0;  i < num; i++ ) {//[00:02.07]偶阵雨 - 梁静茹
        NSUInteger currentTime = [mo changeTime:timeArray[i]];
        if (i + 1< [timeArray count ]) {
            NSUInteger currentTime1 = [mo changeTime:timeArray[i+1]];
            if (audioPlayer.currentTime > currentTime && audioPlayer.currentTime < currentTime1) {
                [self updateLrcTableView:i];
                [_tableView reloadData];
                break;
            }

        }else if (audioPlayer.currentTime > currentTime){//最后一行
            [self updateLrcTableView:i];
            [_tableView reloadData];
            break;
        
        }
        

        }
        
    }


#pragma mark 动态更新歌词表歌词
- (void)updateLrcTableView:(NSUInteger)lineNumber {

    lrcLineNumber = lineNumber;
    [_tableView reloadData];
    if (lineNumber > 0) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lineNumber inSection:0];
        [_tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];//移动到中心位置
    }
   


}
#pragma mark---UITableView代理实现
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;{

    return [timeArray count];

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;{
    static NSString * identifier = @"cell";
    __autoreleasing MyCell * cell = [tableView   dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
       cell.textLabel.text = LRCDictionary[timeArray[indexPath.row]];
    if (indexPath.row == lrcLineNumber) {
        cell.textLabel.textColor = kRGBA(255, 255, 0, 1);
        cell.textLabel.font = kFontSize(15);
    [_tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];//移动到中心位置

    }else{
        cell.textLabel.textColor = kRGBA(0, 0, 0, 0.5f);
        cell.textLabel.font = kFontSize(13);
    
    }
  

    
    return cell;
   

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 35;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark---按钮操作
- (IBAction)play:(id)sender {
    if (isPlay) {
        [audioPlayer play];
        [sender setBackgroundImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];

        isPlay = NO;
    }
    else{
    
        [audioPlayer pause];
        [sender setBackgroundImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];

        isPlay = YES;
    }
    dlog();
}

- (IBAction)aboveButton:(id)sender {
}

- (IBAction)nextButton:(id)sender {
}
- (IBAction)sliderChanged:(id)sender {
    audioPlayer.currentTime =  _slider.value * audioPlayer.duration;
}
- (IBAction)musicList:(id)sender {
//    DXSemiViewController * semiV = [[DXSemiViewController alloc]init];
//    semiV.direction = SemiViewControllerDirectionRight;
//    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(100, 0, 220, 480)];
//    view.backgroundColor = [UIColor redColor];
//    [semiV.view addSubview:view];
//    semiV.sideOffset = 100.0f;
//    semiV.sideAnimationDuration = 0.6f;
//    semiV.title = @"abc";
//
//    semiV.view.backgroundColor = [UIColor yellowColor];
//    self.rightSemiViewController = semiV;
    
}
@end
