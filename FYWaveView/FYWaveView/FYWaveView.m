//
//  FYWaveView.m
//  MaShangLiCai
//
//  Created by hua zhang on 3/9/16.
//  Copyright © 2016 MaShangFeiYang. All rights reserved.
//

#import "FYWaveView.h"

#define degreesToRadians(x) (M_PI*(x)/180.0) //把角度转换成PI的方式

@interface FYWaveView ()<CAAnimationDelegate> {
    CGFloat _curRadius;
    BOOL _adjustSize;
    BOOL _enabled;
}
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) CAShapeLayer *circleLayer;
@end

@implementation FYWaveView

- (id)initWithRadius:(CGFloat)radius color:(UIColor *)color {
    return [self initWithRadius:radius color:color adjustSize:YES];
}

- (id)initWithRadius:(CGFloat)radius color:(UIColor *)color adjustSize:(BOOL)adjustSize {
    self = [super initWithFrame:CGRectMake(0, 0, radius*2, radius*2)];
    if (self) {
        
        self.radius = radius;
        self.color = color;
        _adjustSize = adjustSize;
        [self drawLayer:adjustSize];
    }
    
    return self;
}

- (CGPoint)dotPositionForRadius:(CGFloat)radius degree:(CGFloat)degree  {
    CGFloat x = self.radius+radius*cos(M_PI*2-degreesToRadians(degree));
    CGFloat y = self.radius-radius*sin(M_PI*2-degreesToRadians(degree));
    
    return CGPointMake(x, y);
}


- (void)drawLayer:(BOOL)adjustSize {
    self.circleLayer = [CAShapeLayer layer];
    self.circleLayer.frame = self.bounds;
    [self.layer addSublayer:self.circleLayer];
    
    self.circleLayer.fillColor = self.color.CGColor;
    CGFloat r = 0;
    if (adjustSize) {
       r = arc4random_uniform(15);
    }
    _curRadius = self.radius-r;
    self.circleLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(r, r, _curRadius*2, _curRadius*2)].CGPath;
    
}

- (void)resetAnimation:(BOOL)first {
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat degree = arc4random_uniform(360);
    CGFloat r = arc4random_uniform(15)+5;
    if (!_adjustSize) {
        r = 5;
    }
    
    CGPoint startPoint = [self dotPositionForRadius:self.radius-_curRadius degree:degree];
    if (!first) {
        [path moveToPoint:startPoint];
    } else {
        CGFloat d = arc4random_uniform(3)+2;
        [path moveToPoint:[self dotPositionForRadius:self.radius-_curRadius+d degree:degree]];
    }
    [path addLineToPoint:[self dotPositionForRadius:self.radius-_curRadius+r degree:degree]];
    [path addLineToPoint:startPoint];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    animation.path = path.CGPath;
    animation.autoreverses = NO;
    animation.removedOnCompletion = YES;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.duration = arc4random_uniform(5)+4;
    animation.delegate = self;
    
    [self.circleLayer addAnimation:animation forKey:@"position"];
}

- (void)startAnimation {
    _enabled = YES;
    
    [self resetAnimation:YES];
}

- (void)stopAnimation {
    _enabled = NO;
    [self.circleLayer removeAllAnimations];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self.circleLayer removeAllAnimations];

    if (_enabled) {
        [self resetAnimation:NO];
    }
}

@end
