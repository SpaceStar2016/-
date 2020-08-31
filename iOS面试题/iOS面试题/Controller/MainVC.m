//
//  ViewController.m
//  媒体文件播放_OC
//
//  Created by Space Zhong on 2020/8/5.
//  Copyright © 2020 Space Zhong. All rights reserved.
//

#import "MainVC.h"
#import "MainListCell.h"
#import "MainListModel.h"
#import "CatalogVC.h"
//#import <AVFoundation/AVFoundation.h>

static NSString * const MainListCellID = @"MainListCell";

@interface MainVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * data;
@end

@implementation MainVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    UITableView * tableView = [[UITableView alloc] init];
    tableView.frame = CGRectMake(0,64,self.view.frame.size.width,self.view.frame.size.height - 64);
//    tableView.frame = self.view.bounds;
//    [tableView registerClass:[MainListCell class] forCellReuseIdentifier:MainListCellID];
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MainListCell class]) bundle:nil] forCellReuseIdentifier:MainListCellID];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    
    
    MainListModel * model00 = [[MainListModel alloc] init];
    model00.title = @"OC基础";
    MainListModel * model01 = [[MainListModel alloc] init];
    model01.title = @"UI基础";
    
    
    MainListModel * model02 = [[MainListModel alloc] init];
    model02.title = @"";
    
    

    [self.data addObject:model00];
    [self.data addObject:model01];
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
    
    MainListCell * cell =  [tableView dequeueReusableCellWithIdentifier:MainListCellID];
    MainListModel * model = self.data[indexPath.row];
    cell.model = model;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            CatalogVC *vc = [[CatalogVC alloc] init];
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
