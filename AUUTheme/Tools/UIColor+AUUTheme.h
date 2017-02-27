//
//  UIColor+AUUTheme.h
//  ThemeTest
//
//  Created by JyHu on 2017/2/14.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef RGBA
#define RGBA(R,G,B,A) ((UIColor*)[UIColor colorWithRed:((R)/255.0) green:((G)/255.0) blue:((B)/255.0) alpha:(A)])
#endif

#ifndef RGB
#define RGB(R,G,B) RGBA(R,G,B,1)
#endif

@interface UIColor (AUUTheme)

/**
 根据给定的颜色字符串，从主题内容中找到相对应的颜色值并生成颜色对象

 @param identifier 颜色标识
 @return UIColor
 */
+ (UIColor *)colorWithIdentifier:(NSString *)identifier;

/**
 生成一个随机的颜色

 @return UIColor
 */
+ (UIColor *)randomColor;

/**
 根据给定的16进制的颜色值来生成颜色对象

 @param hex 16进制的颜色值
 @return UIColor
 */
+ (UIColor *)colorWithHex:(NSUInteger)hex;

/**
 根据给定的颜色字符串来生成对应的颜色对象

 @param hexString 颜色字符串，比如 0xAC01D8  #0AF23A
 @return UIColor
 */
+ (UIColor *)colorWithHexString:(NSString *)hexString;

@end
