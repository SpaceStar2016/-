//
//  VI_ME_MBSliderView.h
//  VICam
//
//  Created by Space on 05/07/2018.
//  Copyright © 2018 ZhongSpace. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AVURLAsset;
@class DKMediaSliderView;
@protocol DKMediaSliderViewDelegate <NSObject>

- (void)mediaSliderViewBeginDrageSlider:(DKMediaSliderView *)sliderView;

- (void)mediaSliderView:(DKMediaSliderView *)slider DragingSliderWithValue:(CGFloat)value;

- (void)mediaSliderView:(DKMediaSliderView *)slider SliderDidEndDragWithValue:(CGFloat)value;
@end

@interface DKMediaSliderView : UIView

@property (nonatomic , weak) id<DKMediaSliderViewDelegate> delegate;

+ (instancetype)sliderView;

@property(nonatomic,strong)AVURLAsset * urlAsset;

@property (nonatomic , assign , getter=isSliderDraging) BOOL sliderDraging;

//@property (nonatomic , copy) NSString *begingTiemStr;
//
//@property (nonatomic , copy) NSString *endTimeStr;

- (void)setCurrentSliderValue:(CGFloat)value;

//@property (nonatomic , assign) CGFloat maxValue;

@end
