//
//  UIColor+AUUTheme.m
//  ThemeTest
//
//  Created by JyHu on 2017/2/14.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "UIColor+AUUTheme.h"
#import "AUUThemeManager.h"
#import "NSString+AUUTheme.h"

@implementation UIColor (AUUTheme)

+ (UIColor *)colorWithIdentifier:(NSString *)identifier
{
    NSDictionary *colors = [AUUThemeManager sharedManager].themeInfos[@"colors"];
    
    if (colors)  // 主题信息
    {
        // 从主题中找到颜色信息
        NSString *colorString = colors[identifier];
        
        return colorString ? ([UIColor colorWithHexString:colorString] ?: [self superColorWithColors:colors identifier:identifier]) : [self superColorWithColors:colors identifier:identifier];
    }
    
    return [AUUThemeManager sharedManager].defaultColor;
}

+ (UIColor *)superColorWithColors:(NSDictionary *)colors identifier:(NSString *)identifier
{
    // 找上一级的颜色
    // color.identifier.useingidentfiier
    NSString *superIdentifier = [identifier superIdentifier];
    
    if (!superIdentifier)   // 没有上一级的颜色信息
    {
        NSString *defaultColorString = colors[@"__default__"];
        
        if (defaultColorString) // 找到了，就返回这个默认的颜色，没有找到的话，就出去了，返回设置的默认颜色了。
        {
            UIColor *color = [UIColor colorWithHexString:defaultColorString];
            
            if (color)
            {
                return color;
            }
        }
    }
    else    // 有上一级的颜色信息
    {
        return [UIColor colorWithIdentifier:superIdentifier];
    }
    
    return [AUUThemeManager sharedManager].defaultColor;
}

+ (UIColor *)randomColor
{
    return RGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256));
}

+ (UIColor *)colorWithHex:(NSUInteger)hex
{
    // 带有alpha
    if (hex > (1 << 24) - 1)
    {
        return RGBA((CGFloat)((hex & 0xFF000000) >> 24),
                    (CGFloat)((hex & 0xFF0000) >> 16),
                    (CGFloat)((hex & 0xFF00) >> 8),
                    ((CGFloat)(hex & 0xFF)) / 255.0);
    }
    
    // 仅有RGB
    return RGB((CGFloat)((hex & 0xFF0000) >> 16),
               (CGFloat)((hex & 0xFF00) >> 8),
               (CGFloat)( hex & 0xFF));
}

+ (UIColor *)colorWithHexString:(NSString *)hexString
{
    // 截取有效地颜色值
    NSString *colorHexString = [hexString matchResultWithPattern:@"((?<=0[xX])[0-9a-fA-F]{6,8})|((?<=#)[0-9a-fA-F]{6,8})|(^[0-9a-fA-F]{6,8})"];
    
    if (colorHexString)
    {
        unsigned int colorHexValue = 0;
        NSScanner *scanner = [NSScanner scannerWithString:colorHexString];
        [scanner setScanLocation:0];
        [scanner scanHexInt:&colorHexValue];
        
        return [UIColor colorWithHex:colorHexValue];
    }
    
    return nil;
}

@end
