//
//  DKMediaPlayerView.h
//  媒体文件播放_OC
//
//  Created by Space Zhong on 2020/8/15.
//  Copyright © 2020 Space Zhong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DKMediaPlayerView : UIView
+(instancetype)mediaPlayerView;
-(void)setUrl:(NSString *)url;
//-(void)play;
//-(void)stop;

@end

NS_ASSUME_NONNULL_END
