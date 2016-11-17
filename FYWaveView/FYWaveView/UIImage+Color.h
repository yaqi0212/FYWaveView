//
//  UIImage+Color.h
//  Vidie
//
//  Created by hua zhang on 9/26/14.
//  Copyright (c) 2014 hua zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)

/**
 *	@brief	将颜色变成图片
 *
 *	@param 	color 	图片的颜色
 *	@param 	size 	图片大小
 *
 *	@return	图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 *	@brief	改变图片颜色
 *
 *	@param 	color 图片的颜色
 *
 *	@return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;


- (UIImage *)imageToColor:(UIColor *)color;
- (UIImage *)grayImage;
@end
