//
//  jointVideo.h
//  媒体文件播放_OC
//
//  Created by Space Zhong on 2020/8/30.
//  Copyright © 2020 Space Zhong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@interface jointVideo : NSObject
{
    
    
    
}
@property (nonatomic, strong) AVComposition *mainComposition;
@property (nonatomic, strong) AVAudioMix *audioMix;
@property (nonatomic, strong) AVVideoComposition *videoComposition;

- (void)spliceVideoWithArray:(NSArray *)arrayAssetFile outputFile:(NSString *)outputFile;
@end
