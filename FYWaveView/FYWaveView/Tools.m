//
//  Tools.m
//  MaShangLiCai
//
//  Created by JasonLu on 14/12/3.
//  Copyright (c) 2014年 JasonLu. All rights reserved.
//

#import "Tools.h"
#import <AVFoundation/AVFoundation.h>

#define SCREEN_SIZE [UIScreen mainScreen].bounds.size

@implementation Tools

+ (FYPhoneModel)currentPhoneModel {
    if (SCREEN_SIZE.width>375.0) {
        return FYPhoneModeliPhone6p;
    } else if (SCREEN_SIZE.width>320.0 && SCREEN_SIZE.width <= 375.0) {
        return FYPhoneModeliPhone6;
    } else {
        if (SCREEN_SIZE.height > 480) {
            return FYPhoneModeliPhone5;
        } else {
            return FYPhoneModeliPhone4;
        }
    }
}

+ (CGFloat)fitCGFloatFive:(CGFloat)five six:(CGFloat)six sixp:(CGFloat)sixp{
    if ([self currentPhoneModel] == FYPhoneModeliPhone6) {
        return six;
    }else if ([self currentPhoneModel] == FYPhoneModeliPhone6p){
        return sixp;
    }else{
        return five;
    }
}

+ (UIColor *)colorWithHexValue:(uint)hexValue alpha:(float)alpha
{
    return [UIColor
            colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0
            green:((float)((hexValue & 0xFF00) >> 8))/255.0
            blue:((float)(hexValue & 0xFF))/255.0
            alpha:alpha];
}

+ (UIColor *)colorWithHexString:(NSString *)hexStr alpha:(float)alpha
{
    if (hexStr == nil || (id)hexStr == [NSNull null]) {
        return nil;
    }
    else{
        UIColor *color;
        hexStr = [hexStr stringByReplacingOccurrencesOfString:@"#" withString:@"0x"];
        
        uint hexValue;
        if ([[NSScanner scannerWithString:hexStr] scanHexInt:&hexValue]) {
            color = [self colorWithHexValue:hexValue alpha:alpha];
        }
        else {
            // invalid hex string
            color = [UIColor clearColor];
        }
        return color;
    }
}

+ (UIColor *)colorWithHexString:(NSString *)hexStr {
    
    if (hexStr == nil || (id)hexStr == [NSNull null]) {
        return nil;
    }
    else{
        UIColor *color;
        hexStr = [hexStr stringByReplacingOccurrencesOfString:@"#" withString:@"0x"];
        
        uint hexValue;
        if ([[NSScanner scannerWithString:hexStr] scanHexInt:&hexValue]) {
            color = [self colorWithHexValue:hexValue alpha:1.0];
        }
        else {
            // invalid hex string
            color = [UIColor clearColor];
        }
        return color;
    }
}



@end
