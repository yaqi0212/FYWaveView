//
//  Tools.h
//  MaShangLiCai
//
//  Created by JasonLu on 14/12/3.
//  Copyright (c) 2014年 JasonLu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, FYPhoneModel) {
    FYPhoneModeliPhone4,
    FYPhoneModeliPhone5,
    FYPhoneModeliPhone6,
    FYPhoneModeliPhone6p,
};

@interface Tools : NSObject

+ (FYPhoneModel)currentPhoneModel;
+ (CGFloat)fitCGFloatFive:(CGFloat)five six:(CGFloat)six sixp:(CGFloat)sixp;

+ (UIColor *)colorWithHexValue:(uint)hexValue alpha:(float)alpha;

+ (UIColor *)colorWithHexString:(NSString *)hexStr alpha:(float)alpha;

+ (UIColor *)colorWithHexString:(NSString *)hexStr ;


@end
