//
//  BaseViewVC.m
//  媒体文件播放_OC
//
//  Created by Space Zhong on 2020/8/15.
//  Copyright © 2020 Space Zhong. All rights reserved.
//

#import "BaseViewVC.h"

@interface BaseViewVC ()
@property(nonatomic,strong)UIButton * backButton;

@end

@implementation BaseViewVC

-(instancetype)init
{
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    return self;;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    NSString * newpath = VAImagePathWithName(@"vib_bj_fanhui.png");
    UIImage * image = [UIImage imageWithContentsOfFile:newpath];
//    vib_bj_fanhui
    UIButton * btn = [[UIButton alloc] init];
    btn.frame = CGRectMake(0,64,60,60);
    btn.backgroundColor = [UIColor clearColor];
    [btn setImage:image forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    self.backButton = btn;
    // Do any additional setup after loading the view.
}

-(void)goBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
