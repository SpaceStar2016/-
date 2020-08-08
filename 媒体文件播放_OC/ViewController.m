//
//  ViewController.m
//  媒体文件播放_OC
//
//  Created by Space Zhong on 2020/8/5.
//  Copyright © 2020 Space Zhong. All rights reserved.
//

#import "ViewController.h"
#import <AVKit/AVKit.h>
//#import <AVFoundation/AVFoundation.h>
@interface ViewController ()
@property(nonatomic,strong)AVPlayerViewController * playViewVC;
@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.playViewVC = [[AVPlayerViewController alloc] init];
//    NSString * abPath = @"/Users/spacezhong/Desktop/Video/试讲00.mov";
    NSString * paaa = [[NSBundle mainBundle] pathForResource:@"src" ofType:nil];
    NSString * newpath = [NSString stringWithFormat:@"%@/video/笑傲江湖MP4.mp4",paaa];
    NSURL * fileUrl = [NSURL fileURLWithPath:newpath];
    AVPlayer * play = [AVPlayer playerWithURL:fileUrl];
    self.playViewVC.player = play;
    self.playViewVC.view.frame = self.view.bounds;
    self.playViewVC.view.backgroundColor = [UIColor blackColor];
    self.playViewVC.showsPlaybackControls = YES;
    [self.view addSubview:self.playViewVC.view];
    [self.playViewVC.player play];

    
}


@end
