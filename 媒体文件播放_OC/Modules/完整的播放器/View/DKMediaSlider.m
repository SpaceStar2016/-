//
//  DKMediaSlider.m
//
//  Created by Space on 05/07/2018.
//  Copyright © 2018 ZhongSpace. All rights reserved.
//

#import "DKMediaSlider.h"

@interface DKMediaSlider ()

@property (nonatomic , assign) CGRect lastBounds;
@property (nonatomic, strong) CAShapeLayer *progressLayer;

@end
@implementation DKMediaSlider


- (CGRect)trackRectForBounds:(CGRect)bounds{
    CGRect rect = [super trackRectForBounds:bounds];
    
    rect = CGRectInset(rect, 0, -0.5);
    
    return rect;
}

-(void)setPlayableProgress:(CGFloat)playableProgress{
    self.progressLayer.strokeEnd = playableProgress;
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self setNeedsDisplay];
}

-(void)setBounds:(CGRect)bounds{
    [super setBounds:bounds];
    [self setNeedsDisplay];
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    //放大点击区域
    CGRect zoomInRect = CGRectMake(-10,-(self.frame.size.height+20) * 0.5,self.frame.size.width + 10, self.frame.size.height+20);
    if (CGRectContainsPoint(zoomInRect, point)) {
        return self;
    }
    return [super hitTest:point withEvent:event];
}


@end
