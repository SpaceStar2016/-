//
//  AVPlayViewVC.m
//  媒体文件播放_OC
//
//  Created by Space Zhong on 2020/8/11.
//  Copyright © 2020 Space Zhong. All rights reserved.
//

#import "AVPlayViewVC.h"

@interface AVPlayViewVC ()

@end

@implementation AVPlayViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString * newpath = VAPathWithName(@"笑傲江湖MP4.mp4");
    NSURL * fileUrl = [NSURL fileURLWithPath:newpath];
    AVPlayer * play = [AVPlayer playerWithURL:fileUrl];
    self.videoGravity = AVLayerVideoGravityResizeAspect;
    self.player = play;
    self.view.backgroundColor = [UIColor blackColor];
    self.showsPlaybackControls = YES;
    
    [self.player play];
    
    // Do any additional setup after loading the view.
}

/** AVPlayerViewController demo
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


*/

@end
