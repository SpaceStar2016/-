//
//  DKMediaSliderView.m
//  VICam
//
//  Created by Space on 05/07/2018.
//  Copyright © 2018 ZhongSpace. All rights reserved.
//

#import "DKMediaSliderView.h"
#import "DKMediaSlider.h"
#import <AVFoundation/AVFoundation.h>

@interface DKMediaSliderView ()
@property (weak, nonatomic) IBOutlet DKMediaSlider *slider;
@property (weak, nonatomic) IBOutlet UILabel *beginLabel;
@property (weak, nonatomic) IBOutlet UILabel *endLabel;

@end

@implementation DKMediaSliderView

+ (instancetype)sliderView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
        
    self.backgroundColor = [UIColor blackColor];
    self.endLabel.textColor = [UIColor whiteColor];
    self.beginLabel.textColor = [UIColor whiteColor];
    
    self.slider.continuous = YES;
    self.slider.minimumValue = 0.0f;
    self.slider.value = 0.0;
    self.slider.maximumValue = 1.0f;
//    vic_fd_progresspoint
    [self.slider setThumbImage:[UIImage imageWithContentsOfFile:VAImagePathWithName(@"vic_fd_progresspoint")]
                      forState:UIControlStateNormal];
    
    [self.slider setThumbImage:[UIImage imageWithContentsOfFile:VAImagePathWithName(@"vic_fd_progresspoint")]
                      forState:UIControlStateHighlighted];
    
    self.slider.maximumTrackTintColor = [UIColor whiteColor];
    self.slider.minimumTrackTintColor = SPSColorMaker(0,255,255,1.0);
    
    // 滑块变换的通知
    [self.slider addTarget:self action:@selector(slideTouchDown:) forControlEvents:UIControlEventTouchDown];
    [self.slider addTarget:self action:@selector(slideValueChange:) forControlEvents:UIControlEventValueChanged];
    [self.slider addTarget:self action:@selector(slideTouchCancel:) forControlEvents:UIControlEventTouchUpInside];
    
    self.beginLabel.text = @"00:00";
    self.endLabel.text = @"00:00";
}

-(void)setUrlAsset:(AVURLAsset *)urlAsset
{
    _urlAsset = urlAsset;
    CMTime timea = [self.urlAsset duration];
    double seconds = CMTimeGetSeconds(timea);
    NSDate *durationDate = [NSDate dateWithTimeIntervalSince1970:seconds];
    NSString *durationStr = [self formatCurrentDateIntoString:durationDate FormatterStr:@"mm:ss"];
    self.endLabel.text = durationStr;
}

- (void)setCurrentSliderValue:(CGFloat)value
{
    self.slider.value = value;
    if (self.isSliderDraging) {
        return;
    }
    CMTime timea = [self.urlAsset duration];
    double seconds = CMTimeGetSeconds(timea);
    double curDuration = seconds * value;
    NSDate *durationDate = [NSDate dateWithTimeIntervalSince1970:curDuration];
     NSString *durationStr = [self formatCurrentDateIntoString:durationDate FormatterStr:@"mm:ss"];
    self.beginLabel.text = durationStr;
}



#pragma mark - UISlider

- (void)slideTouchDown:(UISlider*)slider
{
    self.sliderDraging = YES;
    if ([self.delegate respondsToSelector:@selector(mediaSliderViewBeginDrageSlider:)]) {
        [self.delegate mediaSliderViewBeginDrageSlider:self];
    }
}

- (void)slideValueChange:(UISlider*)slider
{
//    int curDuration = _fileModel.assetsModel.phAsset.duration * slider.value;
//    NSString *durationStr = [NSString stringWithFormat:@"%d" , curDuration];
//    self.beginLabel.text = [VI_CamUtils formatTimeWithSecondStr:durationStr];
    
    
    
    if ([self.delegate respondsToSelector:@selector(mediaSliderView:DragingSliderWithValue:)]) {
        [self.delegate mediaSliderView:self DragingSliderWithValue:slider.value];
    }
}

- (void)slideTouchCancel:(UISlider*)slider
{
    self.sliderDraging = NO;
    if ([self.delegate respondsToSelector:@selector(mediaSliderView:SliderDidEndDragWithValue:)]) {
        [self.delegate mediaSliderView:self SliderDidEndDragWithValue:slider.value];
    }
}

-(NSString *)formatCurrentDateIntoString:(NSDate *)date FormatterStr:(NSString *)formatStr
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    //设置日期的类型
    [format setDateStyle:NSDateFormatterLongStyle];
    //设置时间的类型
    [format setTimeStyle:NSDateFormatterShortStyle];
    //设置日期格式
    [format setDateFormat:formatStr];
    NSString *dateStr = [format stringFromDate:date];
    return dateStr;
    
}

@end
