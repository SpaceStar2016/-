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
    model04.title = @"调用系统相机采集视频";
    
    
    AVListModel * model05 = [[AVListModel alloc] init];
    model05.title = @"系统相机采集音视频写到本地";
    
    
    [self.data addObject:model00];
    [self.data addObject:model01];
    [self.data addObject:model02];
    [self.data addObject:model03];
    [self.data addObject:model04];
    [self.data addObject:model05];
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
