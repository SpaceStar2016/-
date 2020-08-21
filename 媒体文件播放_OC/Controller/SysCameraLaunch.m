//
//  SysCameraCapture.m
//  媒体文件播放_OC
//
//  Created by Space Zhong on 2020/8/17.
//  Copyright © 2020 Space Zhong. All rights reserved.
//

#import "SysCameraLaunch.h"
#import <AVFoundation/AVFoundation.h>
@interface SysCameraLaunch ()<AVCaptureVideoDataOutputSampleBufferDelegate,AVCaptureAudioDataOutputSampleBufferDelegate>

@property(nonatomic,strong)AVCaptureSession *capSession;//捕捉会话，用于输入输出设备之间的数据传递
@property(nonatomic,strong)AVCaptureDeviceInput *videoInput;//视频捕捉输入
@property(nonatomic,strong)AVCaptureDeviceInput *audioInput;//音频捕捉输入
@property(nonatomic,strong)AVCaptureAudioDataOutput * audioDataOutput;
@property(nonatomic,strong)AVCaptureVideoDataOutput *videoDataOutput;//捕捉输出
@property(nonatomic,strong)AVCaptureVideoPreviewLayer *previewLayer;//预览图层

//捕捉队列
@property(nonatomic,strong)dispatch_queue_t capQueue;
@end

@implementation SysCameraLaunch


#warning TODO 前后置摄像头切换
#warning TODO 录制的视频保存为宽高为1：1的视频，只要屏幕中间（录制任意大小的视频）

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.capSession.isRunning)return;
    
    self.capQueue = dispatch_queue_create("CAP QUEUE",DISPATCH_QUEUE_SERIAL);
    
    self.capSession = [[AVCaptureSession alloc] init];
    
    //添加视频
    [self addVideoToSession];
    
    //添加音频
    [self addAudioToSession];
    
    //创建连接
    AVCaptureConnection *connection = [self.videoDataOutput connectionWithMediaType:AVMediaTypeVideo];
    
    //设置连接的方向
    [connection setVideoOrientation:AVCaptureVideoOrientationPortrait];
    
    //初始化图层
    self.previewLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:self.capSession];
    [self.previewLayer setVideoGravity:AVLayerVideoGravityResizeAspect];
    [self.previewLayer setFrame:self.view.bounds];
    [self.view.layer addSublayer:self.previewLayer];
    
    [self.capSession startRunning];
    
}

-(void)addVideoToSession
{
    AVCaptureDevice *inputCamera = nil;
     //获取iPhone视频捕捉的设备，例如前置摄像头、后置摄像头......
     NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
     for (AVCaptureDevice *device in devices) {
         //拿到后置摄像头
         if ([device position] == AVCaptureDevicePositionBack) {
             inputCamera = device;
         }
     }
     //将捕捉设备 封装成 AVCaptureDeviceInput 对象
     self.videoInput = [[AVCaptureDeviceInput alloc]initWithDevice:inputCamera error:nil];
     
     
     //判断是否能加入后置摄像头作为输入设备
     if ([self.capSession canAddInput:self.videoInput]) {
         //将设备添加到会话中
         [self.capSession addInput:self.videoInput];
     }
     
     //配置输出
     self.videoDataOutput = [[AVCaptureVideoDataOutput alloc] init];
     
     //设置video的视频捕捉的像素点压缩方式为 420
     [self.videoDataOutput setVideoSettings:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:kCVPixelFormatType_420YpCbCr8BiPlanarFullRange] forKey:(id)kCVPixelBufferPixelFormatTypeKey]];
     
    //设置捕捉代理 和 捕捉队列
     [self.videoDataOutput setSampleBufferDelegate:self queue:self.capQueue];
     
     //判断是否能添加输出
     if ([self.capSession canAddOutput:self.videoDataOutput]) {
         //添加输出
         [self.capSession addOutput:self.videoDataOutput];
     }
}

-(void)addAudioToSession
{
    AVCaptureDevice *inputMicrophone = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
    
    self.audioInput = [[AVCaptureDeviceInput alloc] initWithDevice:inputMicrophone error:nil];
    
    self.audioDataOutput = [[AVCaptureAudioDataOutput alloc] init];
    [self.audioDataOutput setSampleBufferDelegate:self queue:self.capQueue];
    
    [self.capSession beginConfiguration];
    if ([self.capSession canAddInput:self.audioInput]) {
        [self.capSession addInput:self.audioInput];
    }
    if ([self.capSession canAddOutput:self.audioDataOutput]) {
        [self.capSession canAddOutput:self.audioDataOutput];
    }
    [self.capSession commitConfiguration];
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self.capSession stopRunning];
}

#pragma mark - AVCaptureVideoDataOutputSampleBufferDelegate
//AV Foundation 获取到视频流
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    
}


@end
