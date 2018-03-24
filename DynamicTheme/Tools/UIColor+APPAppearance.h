//
//  UIColor+APPAppearance.h
//  DynamicTheme
//
//  Created by 胡金友 on 2018/3/24.
//

#import <UIKit/UIKit.h>
#import "APPAppearanceParamProtocol.h"

@interface UIColor (APPAppearance) <APPAppearanceParamProtocol>

/**
 根据给定的颜色字符串，从主题内容中找到相对应的颜色值并生成颜色对象
 
 @return UIColor
 */
- (UIColor *)correctColor;

/**
 生成一个随机的颜色
 
 @return UIColor
 */
+ (UIColor *)app_randomColor;

/**
 根据给定的16进制的颜色值来生成颜色对象
 
 @param hex 16进制的颜色值
 @return UIColor
 */
+ (UIColor *)app_colorWithHex:(NSUInteger)hex;

/**
 根据给定的颜色字符串来生成对应的颜色对象
 
 @param hexString 颜色字符串，比如 0xAC01D8  #0AF23A
 @return UIColor
 */
+ (UIColor *)app_colorWithHexString:(NSString *)hexString;

@end

