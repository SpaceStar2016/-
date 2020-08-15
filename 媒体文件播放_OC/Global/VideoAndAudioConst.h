//
//  FeiYuCamConst.h
//  FeiYuCam
//
//  Created by ZhongSpace on 2017/8/16.
//  Copyright © 2017年 ZhongSpace. All rights reserved.
//

#import <Foundation/Foundation.h>

#define VAImagePathWithName(name)  [NSString stringWithFormat:@"%@/image/%@",[[NSBundle mainBundle] pathForResource:@"src" ofType:nil],name]

#define SPSColor(r,g,b)  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define SPSRandomColor   SPSColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
#define SPSColorMaker(r, g, b, a) [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]



