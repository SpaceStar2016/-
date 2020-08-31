//
//  ViewController.m
//  媒体文件播放_OC
//
//  Created by Space Zhong on 2020/8/5.
//  Copyright © 2020 Space Zhong. All rights reserved.
//

#import "MainVC.h"
#import <AVKit/AVKit.h>
#import "AVPlayViewVC.h"
#import "AVListModel.h"
#import "AVListCell.h"
#import "AVPlayViewVC.h"
#import "AVPlayerPLocalVC.h"
#import "AVPlayerPAssetVC.h"
#import "DKMediaPlayerVC.h"
#import "SysCameraLaunch.h"
#import "SLVideoToolVC.h"
//#import <AVFoundation/AVFoundation.h>

static NSString * const AVListCellID = @"AVListCell";

@interface MainVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * data;
@property(nonatomic,strong)AVPlayerViewController * playViewVC;
@end

@implementation MainVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    UITableView * tableView = [[UITableView alloc] init];
    tableView.frame = CGRectMake(0,64,self.view.frame.size.width,self.view.frame.size.height - 64);
//    tableView.frame = self.view.bounds;
//    [tableView registerClass:[AVListCell class] forCellReuseIdentifier:AVListCellID];
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([AVListCell class]) bundle:nil] forCellReuseIdentifier:AVListCellID];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    
    
    AVListModel * model00 = [[AVListModel alloc] init];
    model00.title = @"利用AVPlayerViewController 播放本地mp4 文件";
    AVListModel * model01 = [[AVListModel alloc] init];
    model01.title = @"利用AVPlayer 播放本地mp4 文件";
    
    
    AVListModel * model02 = [[AVListModel alloc] init];
    model02.title = @"利用AVPlayer 播放相册 文件";
    
    
    AVListModel * model03 = [[AVListModel alloc] init];
    model03.isMain = YES;
    model03.title = @"一个完整的播放器(基于AVPlayer)";
    
    
    AVListModel * model04 = [[AVListModel alloc] init];
    model04.title = @"调用系统相机采集视频和音频";
    
    
    AVListModel * model05 = [[AVListModel alloc] init];
    model05.title = @"合成MP4文件";
    
    AVListModel * model06 = [[AVListModel alloc] init];
    model06.title = @"测试SLVideoTool";
    

    
    
    [self.data addObject:model00];
    [self.data addObject:model01];
    [self.data addObject:model02];
    [self.data addObject:model03];
    [self.data addObject:model04];
    [self.data addObject:model05];
    [self.data addObject:model06];
}

#pragma mark UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    AVListCell * cell =  [tableView dequeueReusableCellWithIdentifier:AVListCellID];
    AVListModel * model = self.data[indexPath.row];
    cell.model = model;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        //利用AVPlayerViewController 播放 mp4 文件
        case 0:
        {
            AVPlayViewVC * avViewVC = [[AVPlayViewVC alloc] init];
            [self presentViewController:avViewVC animated:YES completion:nil];
        }
            break;
        case 1:
        {
            AVPlayerPLocalVC * playVC = [[AVPlayerPLocalVC alloc] init];
            [self presentViewController:playVC animated:YES completion:nil];
        }
            break;
        case 2:
        {
            AVPlayerPAssetVC * phS = [[AVPlayerPAssetVC alloc] init];
            [self presentViewController:phS animated:YES completion:nil];
        }
            break;
        case 3:
        {
#warning TODO 显示视频信息
            DKMediaPlayerVC * vc = [[DKMediaPlayerVC alloc] initWithUrl:nil];
            [self presentViewController:vc animated:YES completion:nil];
        }
            break;
            case 4:
        {
            SysCameraLaunch * vc = [[SysCameraLaunch alloc] init];
            [self presentViewController:vc animated:YES completion:nil];
        }
            break;
        case 5:
            break;
        case 6:
        {
            SLVideoToolVC * tVC = [[SLVideoToolVC alloc] init];
            [self presentViewController:tVC animated:YES completion:nil];
            
        }
            break;
            
        default:
            break;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}


#pragma mark lazy-load

-(NSMutableArray *)data
{
    if (_data == nil) {
        _data = [NSMutableArray array];
    }
    return _data;
}




@end

/**
 使用MP4v2合成视频，发现AVPlayer播放都是从第二个关键帧开始播放，调试发现原来第一个关键帧前面有个SEI。

 比如iOS，使用AVAssetWriter录制视频，再使用AVAssetReader读取h264数据，再通过MP4v2合成视频，
 读取到的第一个关键帧是包含一个SEI的。
 读到的第一个h264 buf格式是这样的： SEI 长度   SEI 内容   I帧长度  I帧内容。

 把SEI这部分东西去掉之后，使用MP4v2写入之后正常了。

 另外，AVAssetReader读取的数据的时间戳可能不是顺序的，这时候看看视频是不是包含I、B、P帧。
 我们在使用使用AVAssetWriter录制视频时，AVVideoProfileLevelKey设置成AVVideoProfileLevelH264BaselineAutoLevel，
 视频就只包含I、P帧，时间戳读出来也是顺序的了。
 */
