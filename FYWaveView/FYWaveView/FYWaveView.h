//
//  FYWaveView.h
//  MaShangLiCai
//
//  Created by hua zhang on 3/9/16.
//  Copyright © 2016 MaShangFeiYang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FYWaveView : UIView

- (id)initWithRadius:(CGFloat)radius color:(UIColor *)color;
- (id)initWithRadius:(CGFloat)radius color:(UIColor *)color adjustSize:(BOOL)adjustSize;

- (void)startAnimation;
- (void)stopAnimation;
@end
