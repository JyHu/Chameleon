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

@dynamic app_tintColor;
@dynamic app_onTintColor;
@dynamic app_thumbTintColor;
@dynamic app_onImage;
@dynamic app_offImage;

- (void)setApp_tintColor:(UIColor *)app_tintColor {
    [self cacheThemeParams:@[app_tintColor] forSelector:@selector(setTintColor:)];
}

- (void)setApp_onTintColor:(UIColor *)app_onTintColor {
    [self cacheThemeParams:@[app_onTintColor] forSelector:@selector(setOnTintColor:)];
}

- (void)setApp_thumbTintColor:(UIColor *)app_thumbTintColor {
    [self cacheThemeParams:@[app_thumbTintColor] forSelector:@selector(setThumbTintColor:)];
}

- (void)setApp_onImage:(UIImage *)app_onImage {
    [self cacheThemeParams:@[app_onImage] forSelector:@selector(setOnImage:)];
}

- (void)setApp_offImage:(UIImage *)app_offImage {
    [self cacheThemeParams:@[app_offImage] forSelector:@selector(setOffImage:)];
}

@end
