//
//  UITextView+AUUTheme.m
//  ThemeTest
//
//  Created by JyHu on 2017/2/14.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "UITextView+AUUTheme.h"
#import "NSObject+AUUTheme.h"

@implementation UITextView (AUUTheme)

- (void)setApp_tintColor:(UIColor *)app_tintColor {
    [self cacheThemeParams:@[app_tintColor] forSelector:@selector(setTintColor:)];
}

- (UIColor *)app_tintColor {
    return [self cachedParamForSelector:@selector(setTintColor:)];
}

- (void)setApp_textColor:(UIColor *)app_textColor {
    [self cacheThemeParams:@[app_textColor] forSelector:@selector(setTextColor:)];
}

- (UIColor *)app_textColor {
    return [self cachedParamForSelector:@selector(setTextColor:)];
}

@end
