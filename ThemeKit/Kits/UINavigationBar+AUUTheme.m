//
//  UINavigationBar+AUUTheme.m
//  ThemeTest
//
//  Created by JyHu on 2017/2/25.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "UINavigationBar+AUUTheme.h"
#import "NSObject+AUUTheme.h"

@implementation UINavigationBar (AUUTheme)

- (void)setApp_titleColor:(UIColor *)app_titleColor {
    [self cacheThemeParams:@[app_titleColor] forSelector:@selector(_setNavibarTitleColor:)];
}

- (void)setApp_BackgroundImage:(UIImage *)image forBarMetrics:(UIBarMetrics)barMetrics {
    [self cacheThemeParams:@[image, @(barMetrics)] forSelector:@selector(setBackgroundImage:forBarMetrics:)];
}

- (void)_setNavibarTitleColor:(UIColor *)titleColor {
    NSMutableDictionary *titleAttributes = [self.titleTextAttributes mutableCopy];
    if (titleColor) {
        [titleAttributes setObject:titleColor forKey:NSForegroundColorAttributeName];
        self.titleTextAttributes = titleAttributes;
    }
}

@end
