//
//  AVListModel.h
//  媒体文件播放_OC
//
//  Created by Space Zhong on 2020/8/11.
//  Copyright © 2020 Space Zhong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AVListModel : NSObject
@property(nonatomic,copy)NSString * title;
@property(nonatomic,assign)BOOL isMain;
@end

NS_ASSUME_NONNULL_END
