//
//  SysCameraCapture.m
//  媒体文件播放_OC
//
//  Created by Space Zhong on 2020/8/17.
//  Copyright © 2020 Space Zhong. All rights reserved.
//

#import "SysCameraLaunch.h"
#import <AVFoundation/AVFoundation.h>
@interface SysCameraLaunch ()<AVCaptureVideoDataOutputSampleBufferDelegate>

@property(nonatomic,strong)AVCaptureSession *capSession;//捕捉会话，用于输入输出设备之间的数据传递
@property(nonatomic,strong)AVCaptureDeviceInput *deviceInput;//捕捉输入
@property(nonatomic,strong)AVCaptureVideoDataOutput *videoDataOutput;//捕捉输出
@property(nonatomic,strong)AVCaptureVideoPreviewLayer *previewLayer;//预览图层

//捕捉队列
@property(nonatomic,strong)dispatch_queue_t capQueue;
@end

@implementation SysCameraLaunch

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.capSession.isRunning)return;
    
    self.capQueue = dispatch_queue_create("CAP QUEUE",DISPATCH_QUEUE_SERIAL);
    
    self.capSession = [[AVCaptureSession alloc] init];
    
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
    self.deviceInput = [[AVCaptureDeviceInput alloc]initWithDevice:inputCamera error:nil];
    
    //判断是否能加入后置摄像头作为输入设备
    if ([self.capSession canAddInput:self.deviceInput]) {
        //将设备添加到会话中
        [self.capSession addInput:self.deviceInput];
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
