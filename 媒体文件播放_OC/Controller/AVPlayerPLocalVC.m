//
//  AVPlayerVC.m
//  媒体文件播放_OC
//
//  Created by Space Zhong on 2020/8/11.
//  Copyright © 2020 Space Zhong. All rights reserved.
//

#import "AVPlayerPLocalVC.h"
#import <AVFoundation/AVFoundation.h>
@interface AVPlayerPLocalVC ()
@end

@implementation AVPlayerPLocalVC

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString * newpath = VAPathWithName(@"笑傲江湖MP4.mp4");
    AVPlayerItem * playItem = [[AVPlayerItem alloc] initWithURL:[NSURL fileURLWithPath:newpath]];
    
    AVPlayer * player = [AVPlayer playerWithPlayerItem:playItem];
    
    AVPlayerLayer *avLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    avLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    avLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:avLayer];
    
    [player play];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
