//
//  AVPlayerPAssetVC.m
//  媒体文件播放_OC
//
//  Created by Space Zhong on 2020/8/11.
//  Copyright © 2020 Space Zhong. All rights reserved.
//

#import "AVPlayerPAssetVC.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
@interface AVPlayerPAssetVC ()

@end

@implementation AVPlayerPAssetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton * btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(0,64,60,60);
    btn.backgroundColor = [UIColor whiteColor];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    //获取相册中的视频文件
    [self allAlbumVideos:nil Completion:^(NSArray * assets)
    {
        PHAsset * aset = assets.firstObject;
        if (!aset) {
            NSLog(@"相册没有视频文件~~");
            return ;
        }
        //根据PHAsset 生成 AVURLAsset
        PHImageManager *manager = [PHImageManager defaultManager];
        PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
        options.version = PHImageRequestOptionsVersionCurrent;
        options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
        [manager requestAVAssetForVideo:aset options:options resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
           AVURLAsset *urlAsset = (AVURLAsset *)asset;
           NSURL *url = urlAsset.URL;
            dispatch_async(dispatch_get_main_queue(), ^{
                AVPlayerItem * playItem = [[AVPlayerItem alloc] initWithURL:url];
                AVPlayer * player = [AVPlayer playerWithPlayerItem:playItem];
                
                AVPlayerLayer *avLayer = [AVPlayerLayer playerLayerWithPlayer:player];
                avLayer.videoGravity = AVLayerVideoGravityResizeAspect;
                avLayer.frame = self.view.bounds;
                [self.view.layer addSublayer:avLayer];
                [player play];
            });
        }];
        
    }];
    
    
//    NSURL *videoUrl = [NSURL URLWithString:asset.localizedDescription];
//
//
//    AVAsset *avasset = [AVAsset assetWithURL:videoUrl];
    
    
    
    
}

-(void)allAlbumVideos:(NSString *)albumName Completion:(void(^)(NSArray *))completion
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray* photos = [self fetchAssetsWithAlbumName:albumName mediaType:PHAssetMediaTypeVideo];
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(photos);
        });
    });
}

//查找指定相册内的文件
-(NSArray<PHAsset *> *)fetchAssetsWithAlbumName:(NSString *)albumName mediaType:(PHAssetMediaType)mediaType
{
    NSMutableArray* photos = [[NSMutableArray alloc]init];
    NSMutableArray* videos = [[NSMutableArray alloc]init];
    NSMutableArray* allObjects = [[NSMutableArray alloc]init];
    //设置模糊查询条件
    PHFetchOptions *fetchOptions =[[PHFetchOptions alloc]init];
    
    PHFetchResult *assets = nil;
    if (albumName) {
        
        fetchOptions.predicate = [NSPredicate predicateWithFormat:@"localizedTitle == %@",albumName];
        //列出本应用创建的相册
        PHFetchResult *collections = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:fetchOptions];
        //获取指定相册内所有Asset文件
        assets = [PHAsset fetchAssetsInAssetCollection:collections.firstObject options:nil];
    }
    else {
        
        assets = [PHAsset fetchAssetsWithOptions:fetchOptions];
    }
    
    for (PHAsset *asset in assets) {
        
        //图片
        if (asset.mediaType == PHAssetMediaTypeImage) {
            [photos addObject:asset];
        }
        //视频
        else if (asset.mediaType == PHAssetMediaTypeVideo) {
            [videos addObject:asset];
        }
        [allObjects addObject:asset];//所有图片对象以及视频对象
    }
    
    if (mediaType == PHAssetMediaTypeImage) {//返回全图片数组
        return photos;
    }
    else if (mediaType == PHAssetMediaTypeVideo) {//返回全视频数组
        return videos;
    }
    else {
        [allObjects sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]]];
        return allObjects;//返回所有图片对象以及视频对象数组
    }
}

-(void)goBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
