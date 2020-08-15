//
//  DKMediaPlayerVC.m
//  媒体文件播放_OC
//
//  Created by Space Zhong on 2020/8/15.
//  Copyright © 2020 Space Zhong. All rights reserved.
//

#import "DKMediaPlayerVC.h"
#import "DKMediaPlayerView.h"
@interface DKMediaPlayerVC ()
@property(nonatomic,strong)DKMediaPlayerView * playerView;
@property(nonatomic,copy)NSString * url;
@end

@implementation DKMediaPlayerVC

-(instancetype)initWithUrl:(NSString *)url
{
    if (self = [super init]) {
        self.url = url;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.playerView = [DKMediaPlayerView mediaPlayerView];
    self.playerView.frame = self.view.bounds;
    [self.view addSubview:self.playerView];
    if (!self.url) {
        NSString * paaa = [[NSBundle mainBundle] pathForResource:@"src" ofType:nil];
        NSString * newpath = [NSString stringWithFormat:@"%@/video/笑傲江湖MP4.mp4",paaa];
        self.url = newpath;
    }
    [self.playerView setUrl:self.url];
    [self.view bringSubviewToFront:self.backButton];
}

@end
