//
//  VI_ME_MBSlider.h
//  VICam
//
//  Created by Space on 05/07/2018.
//  Copyright © 2018 ZhongSpace. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DKMediaSlider;
@protocol VI_ME_MBSliderDelegate <NSObject>

- (void)meMBSlider:(DKMediaSlider *)slider valueChagedDidEnd:(CGFloat)value;

@end

@interface DKMediaSlider : UISlider
@property(nonatomic,assign)CGFloat playableProgress;

@property(nonatomic,weak)id<VI_ME_MBSliderDelegate>delegate;
@end
