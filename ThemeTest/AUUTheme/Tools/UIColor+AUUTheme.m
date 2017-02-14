//
//  UIColor+AUUTheme.m
//  ThemeTest
//
//  Created by JyHu on 2017/2/14.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "UIColor+AUUTheme.h"
#import "AUUThemeManager.h"
#import "NSString+_AUUPrivateHelper.h"

@implementation UIColor (AUUTheme)

+ (UIColor *)colorWithIdentifier:(NSString *)identifier
{
    NSString *colorString = [AUUThemeManager sharedManager].themeInfos[@"colors"][identifier];
    return colorString ? [UIColor colorWithHexString:colorString] : [AUUThemeManager sharedManager].defaultColor;
}

+ (UIColor *)randomColor
{
    return RGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256));
}

+ (UIColor *)colorWithHex:(NSUInteger)hex
{
    if (hex > (1 << 24) - 1)
    {
        return RGBA((CGFloat)((hex & 0xFF000000) >> 24),
                    (CGFloat)((hex & 0xFF0000) >> 16),
                    (CGFloat)((hex & 0xFF00) >> 8),
                    ((CGFloat)(hex & 0xFF)) / 255.0);
    }
    
    return RGB((CGFloat)((hex & 0xFF0000) >> 16),
               (CGFloat)((hex & 0xFF00) >> 8),
               (CGFloat)( hex & 0xFF));
}

+ (UIColor *)colorWithHexString:(NSString *)hexString
{
    NSString *colorHexString = [hexString matchResultWithPattern:@"((?<=0[xX])[0-9a-fA-F]{6})|((?<=#)[0-9a-fA-F]{6})|(^[0-9a-fA-F]{6})"];
    
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
