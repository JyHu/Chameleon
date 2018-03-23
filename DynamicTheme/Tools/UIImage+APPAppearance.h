//
//  UIImage+APPAppearance.h
//  DynamicTheme
//
//  Created by 胡金友 on 2018/3/23.
//

#import <UIKit/UIKit.h>
#import "APPAppearanceParamProtocol.h"


@interface UIImage (APPAppearance) <APPAppearanceParamProtocol>

/**
 根据给定的标识符来找到当前主题中所对应的土坯那
 
 @return 返回找到的图片，否则返回默认的图片
 */
- (UIImage *)correctImageWithURLString:(NSString **)urlString;

/**
 根据给定的颜色，返回一张纯色的照片
 
 @param color UIColor
 @param size 图片的大小
 @return 纯色的图片
 */
+ (UIImage *)app_imageWithColor:(UIColor *)color size:(CGSize)size;
+ (UIImage *)app_imageWithColor:(UIColor *)color;

@end
