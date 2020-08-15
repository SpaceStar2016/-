//
//  DKMediaPlayerView.m
//  媒体文件播放_OC
//
//  Created by Space Zhong on 2020/8/15.
//  Copyright © 2020 Space Zhong. All rights reserved.
//

#import "DKMediaPlayerView.h"
#import <AVFoundation/AVFoundation.h>
#import "DKMediaSliderView.h"
#define WEAKSELF __weak typeof(self) weakSelf = self
@interface DKMediaPlayerView()<DKMediaSliderViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (nonatomic , weak) AVPlayerLayer *playerLayer;
@property (nonatomic, weak) AVPlayer *player;
@property (nonatomic, weak) AVPlayerItem *playerItem;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (nonatomic, strong) NSObject *playbackTimeObserver;

@property(nonatomic,strong)AVURLAsset * urlAsset;

@property(nonatomic,strong)DKMediaSliderView * slideView;
@end

@implementation DKMediaPlayerView

+(instancetype)mediaPlayerView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"DKMediaPlayerView" owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    NSString * path =  VAImagePathWithName(@"vib_zy_playing.png"
                                           );
    
    UIImage * image = [UIImage imageWithContentsOfFile:path];
    [self.playBtn setImage:image forState:UIControlStateNormal];
    
    self.slideView = [DKMediaSliderView sliderView];
    self.slideView.delegate = self;
    [self addSubview:self.slideView];
}


//vib_zy_playing

-(void)setUrl:(NSString *)urlstr;
{
    NSURL * url = [NSURL fileURLWithPath:urlstr];
    if (!url) {
        NSLog(@"url error%@",urlstr);
        return;
    }
    // 创建播放器
    AVPlayerItem *item = [AVPlayerItem playerItemWithURL:url];
    AVPlayer *player = [AVPlayer playerWithPlayerItem:item];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    self.playerItem = item;
    self.player = player;
    [self.playerLayer removeFromSuperlayer];
    [self.layer insertSublayer:playerLayer above:self.backImageView.layer];
    self.playerLayer = playerLayer;
    self.playerLayer.frame = self.bounds;
    //设置监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(avPlayerItemDidPlayToEndTime) name:AVPlayerItemDidPlayToEndTimeNotification object:self.playerItem];
    WEAKSELF;
    _playbackTimeObserver = [_player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:NULL usingBlock:^(CMTime time) {
        CGFloat videoDuration = weakSelf.playerItem.duration.value / weakSelf.playerItem.duration.timescale;
        CGFloat currentTime = weakSelf.playerItem.currentTime.value / weakSelf.playerItem.currentTime.timescale;
        CGFloat progress = currentTime / videoDuration;
        [weakSelf.slideView setCurrentSliderValue:progress];
        NSLog(@"progress == %f",progress);
    }];
    
    //获取视频信息
    self.urlAsset = [AVURLAsset assetWithURL:url];
    self.slideView.urlAsset = self.urlAsset;
    NSLog(@"---");

}

-(void)stop
{
    
}

- (void)seekToValue:(CGFloat)value
{
    CMTime timea = [self.urlAsset duration];
    int seconds = ceil(timea.value/timea.timescale);
    CGFloat time = seconds * value;
    WEAKSELF;
    [self.player seekToTime:CMTimeMakeWithSeconds(time, NSEC_PER_SEC) completionHandler:^(BOOL finished) {
        weakSelf.playBtn.hidden = YES;
        [weakSelf.player play];
    }];
}

- (IBAction)playBtnDidClick:(id)sender {
    self.playBtn.hidden = !self.playBtn.isHidden;
    if (self.playBtn.hidden) {
        [self.player play];
    }
    else
    {
        [self.player pause];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.player pause];
    self.playBtn.hidden = NO;
}

#pragma mark DKMediaSliderViewDelegate
- (void)mediaSliderViewBeginDrageSlider:(DKMediaSliderView *)sliderView
{
    
}

- (void)mediaSliderView:(DKMediaSliderView *)slider DragingSliderWithValue:(CGFloat)value
{
    
}

- (void)mediaSliderView:(DKMediaSliderView *)slider SliderDidEndDragWithValue:(CGFloat)value
{
    [self seekToValue:value];
}

#pragma mark notification

- (void)avPlayerItemDidPlayToEndTime
{
    WEAKSELF;
    [_player seekToTime:kCMTimeZero completionHandler:^(BOOL finished) {
        weakSelf.playBtn.hidden = NO;
    }];
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat slideW = self.width;
    CGFloat slideH = 30;
    CGFloat slideY = self.height - slideH - 10;
    CGFloat slideX = 0;
    self.slideView.frame = CGRectMake(slideX, slideY, slideW, slideH);
}


-(void)dealloc
{
    [self.player pause];
    [self.player cancelPendingPrerolls];
   [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:self.playerItem];
   self.playerItem = nil;
   
   if (_playbackTimeObserver) {
       [_player removeTimeObserver:_playbackTimeObserver];
       _playbackTimeObserver = nil;
   }
}




@end
