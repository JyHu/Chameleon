//
//  UISwitch+AUUTheme.m
//  ThemeTest
//
//  Created by JyHu on 2017/2/14.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "UISwitch+AUUTheme.h"
#import "NSObject+AUUTheme.h"

@implementation UISwitch (AUUTheme)

- (void)setApp_tintColor:(UIColor *)app_tintColor {
    [self cacheThemeParams:@[app_tintColor] forSelector:@selector(setTintColor:)];
}
- (UIColor *)app_tintColor {
    return [self cachedParamForSelector:@selector(setTintColor:)];
}

- (void)setApp_onTintColor:(UIColor *)app_onTintColor {
    [self cacheThemeParams:@[app_onTintColor] forSelector:@selector(setOnTintColor:)];
}
- (UIColor *)app_onTintColor {
    return [self cachedParamForSelector:@selector(setOnTintColor:)];
}

- (void)setApp_thumbTintColor:(UIColor *)app_thumbTintColor {
    [self cacheThemeParams:@[app_thumbTintColor] forSelector:@selector(setThumbTintColor:)];
}
- (UIColor *)app_thumbTintColor {
    return [self cachedParamForSelector:@selector(setThumbTintColor:)];
}

- (void)setApp_onImage:(UIImage *)app_onImage {
    [self cacheThemeParams:@[app_onImage] forSelector:@selector(setOnImage:)];
}
- (UIImage *)app_onImage {
    return [self cachedParamForSelector:@selector(setOnImage:)];
}

- (void)setApp_offImage:(UIImage *)app_offImage {
    [self cacheThemeParams:@[app_offImage] forSelector:@selector(setOffImage:)];
}
- (UIImage *)app_offImage {
    return [self cachedParamForSelector:@selector(setOffImage:)];
}

@end
