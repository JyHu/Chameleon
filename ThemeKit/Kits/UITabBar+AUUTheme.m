//
//  UITabBar+AUUTheme.m
//  ThemeTest
//
//  Created by 胡金友 on 2017/2/23.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "UITabBar+AUUTheme.h"
#import "NSObject+AUUTheme.h"

@implementation UITabBar (AUUTheme)

- (void)setApp_tintColor:(UIColor *)app_tintColor {
    [self cacheThemeParams:@[app_tintColor] forSelector:@selector(setTintColor:)];
}

- (void)setApp_barTintColor:(UIColor *)app_barTintColor {
    [self cacheThemeParams:@[app_barTintColor] forSelector:@selector(setBarTintColor:)];
}

- (void)setApp_unselectedItemTintColor:(UIColor *)app_unselectedItemTintColor {
    [self cacheThemeParams:@[app_unselectedItemTintColor] forSelector:@selector(setUnselectedItemTintColor:)];
}

- (void)setApp_selectedImageTintColor:(UIColor *)app_selectedImageTintColor {
    [self cacheThemeParams:@[app_selectedImageTintColor] forSelector:@selector(setSelectedImageTintColor:)];
}

- (void)setApp_backgroundImage:(UIImage *)app_backgroundImage {
    [self cacheThemeParams:@[app_backgroundImage] forSelector:@selector(setBackgroundImage:)];
}

- (void)setApp_selectionIndicatorImage:(UIImage *)app_selectionIndicatorImage {
    [self cacheThemeParams:@[app_selectionIndicatorImage] forSelector:@selector(setSelectionIndicatorImage:)];
}

- (void)setApp_shadowImage:(UIImage *)app_shadowImage {
    [self cacheThemeParams:@[app_shadowImage] forSelector:@selector(setShadowImage:)];
}

@end
