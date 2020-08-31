//
//  SLVideoToolVC.m
//  媒体文件播放_OC
//
//  Created by Space Zhong on 2020/8/30.
//  Copyright © 2020 Space Zhong. All rights reserved.
//

#import "SLVideoToolVC.h"
#import "SLVideoTool.h"
#import <AVFoundation/AVFoundation.h>
#import "PCMPlayer.h"
#import "jointVideo.h"

@interface SLVideoToolVC ()<SLVideoToolDelegate>
@property (nonatomic,strong) SLVideoTool *videoTool;
@property (nonatomic,strong) AVAssetReader *assetReader;
@property (nonatomic,strong) AVAsset *AVAsset;
@property (nonatomic,strong) AVAssetReaderTrackOutput *videoTrackOutput;
@property (nonatomic,strong) AVAssetReaderTrackOutput *audioTrackOutput;
@property (nonatomic,strong) AVMutableAudioMix *audioMix;
@property (nonatomic,strong) PCMPlayer *players;
@end

@implementation SLVideoToolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *audioInpitUrl2 = [NSURL fileURLWithPath:VAPathWithName(@"412.mp3")];
    // 视频来源
    NSURL *videoInputUrl = [NSURL fileURLWithPath:VAPathWithName(@"笑傲江湖MP4.mp4")];
    _videoTool = [[SLVideoTool alloc]initWithURL:videoInputUrl];
    _videoTool.delegate = self;
    BOOL isMix;
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    [parametersDic setObject:audioInpitUrl2 forKey:SLVideoMixingAudioParameterAudioAssetURLKey];
    [parametersDic setObject:@"0" forKey:SLVideoMixingAudioParameterVideoVolumeKey];
    [parametersDic setObject:@"1" forKey:SLVideoMixingAudioParameterAudioVolumeKey];
    [parametersDic setValue:[NSValue valueWithCMTime:CMTimeMake(100, 100)] forKey:SLVideoMixingAudioParameterAudioStartTimeKey];
    [parametersDic setValue:[NSValue valueWithCMTimeRange:CMTimeRangeMake(CMTimeMake(100, 100), CMTimeMake(500, 100))] forKey:SlVideoMixingAudioParameterTimeRangeOfAudioKey];
    [parametersDic setValue:[NSValue valueWithCMTimeRange:CMTimeRangeMake(CMTimeMake(0, 100), CMTimeMake(5000, 100))] forKey:SLVideoMixingAudioParameterTimeRangeOfVideoKey];
//    isMix = [_videoTool mixAudioWithParameters:parametersDic];
    [parametersDic setValue:[NSValue valueWithCMTimeRange:CMTimeRangeMake(CMTimeMake(100, 100), CMTimeMake(300, 100))] forKey:SlVideoMixingAudioParameterTimeRangeOfAudioKey];
    [parametersDic setValue:[NSValue valueWithCMTimeRange:CMTimeRangeMake(CMTimeMake(0, 100), CMTimeMake(500, 100))] forKey:SLVideoMixingAudioParameterTimeRangeOfVideoKey];
    isMix = [_videoTool mixAudioWithParameters:parametersDic];
    
//    if (isMix) {
//        NSLog(@"混音成功");
//    } else {
//        NSLog(@"混音失败");
//    }

//    [_videoTool runBackward];
//    [_videoTool upendVideo];
//    [_videoTool clipWithTimeRange:CMTimeRangeMake(CMTimeMake(1200, 600), CMTimeMake(1200, 500))];
//    [self adfasd];
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *videoFileName = @"TempVideo.mp4";
    NSString *targetPath = [documentPath stringByAppendingPathComponent:videoFileName];
    NSFileManager *filrManage = [NSFileManager defaultManager];
    [filrManage removeItemAtPath:targetPath error:nil];
    NSLog(@"==>%@",targetPath);

    
//    jointVideo *spliceTool = [[jointVideo alloc] init];
    NSMutableArray *arrayFile = [NSMutableArray array];
    [arrayFile addObject:[[NSBundle mainBundle] pathForResource:@"a" ofType:@"m4v"]];
    [arrayFile addObject:[[NSBundle mainBundle] pathForResource:@"b" ofType:@"m4v"]];
    
    [arrayFile addObject:[[NSBundle mainBundle] pathForResource:@"c" ofType:@"m4v"]];
    [arrayFile addObject:[[NSBundle mainBundle] pathForResource:@"a" ofType:@"m4v"]];
    
    [arrayFile addObject:[[NSBundle mainBundle] pathForResource:@"b" ofType:@"m4v"]];
    [arrayFile addObject:[[NSBundle mainBundle] pathForResource:@"c" ofType:@"m4v"]];
    
    
    [_videoTool spliceVideoWithArray:arrayFile type:SLVideoTransitionTypePush];
    
    
    [self adfasdWithComposition:_videoTool.mainComposition audioMix:_videoTool.videoAudioMixTools videoCompositon:_videoTool.selectVideoComposition];
    [_videoTool writerFile:[NSURL fileURLWithPath:targetPath]];
    
}

- (void)adfasdWithComposition:(AVAsset *)composition audioMix:(AVAudioMix *)audioMix videoCompositon:(AVVideoComposition *)videoComposition{
    AVPlayerItem *item = [AVPlayerItem playerItemWithAsset:composition];
    [item setAudioMix:audioMix];
    item.videoComposition = videoComposition;
    AVPlayer *tmpPlayer = [AVPlayer playerWithPlayerItem:item];
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:tmpPlayer];
    playerLayer.frame = self.view.bounds;
    playerLayer.videoGravity = AVLayerVideoGravityResize;
    tmpPlayer.volume = 1;
    [self.view.layer addSublayer:playerLayer];
    [tmpPlayer play];
}

- (void)synthesisResult:(BOOL)result{
    if (result) {
        //新的视频文件编码完毕，写入相册。
        NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSString *videoFileName = @"TempVideo.mp4";
        NSString *targetPath = [documentPath stringByAppendingPathComponent:videoFileName]; // 重新编码后的视频保存路径。
        NSLog(@"==>%@",targetPath);
        UISaveVideoAtPathToSavedPhotosAlbum(targetPath, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
    } else {
        NSLog(@"失败");
    }
}
- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"编码完毕" message:@"已写入系统相册" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

- (PCMPlayer *)players{
    if (!_players) {
        _players = [[PCMPlayer alloc]init];
    }
    return _players;
}

- (void)copyAudioSampleBufferRef:(CMSampleBufferRef)sampleBufferRef{
//
//    char szBuf[4096];
//    int  nSize = sizeof(szBuf);
//    if ( [self.players encoderAAC:sampleBufferRef aacData:szBuf aacLen:&nSize]) {
//        NSData *data = [NSData dataWithBytes:szBuf length:nSize];
//        NSUInteger len = [data length];
//        Byte *byteData = (Byte*)malloc(len);
//        memcpy(byteData, [data bytes], len);
//        [self.players playAudioWithData:data];
//    }

//    if (sampleBufferRef) {
//      [self.players playAudioWithSampleBufferRef:sampleBufferRef];
//    }
    

}

@end
