//
//  UISegmentedControl+AUUTheme.m
//  ThemeTest
//
//  Created by JyHu on 2017/2/14.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "UISegmentedControl+AUUTheme.h"
#import "NSObject+AUUTheme.h"

@implementation UISegmentedControl (AUUTheme)

- (void)setApp_tintColor:(UIColor *)app_tintColor {
    [self cacheThemeParams:@[app_tintColor] forSelector:@selector(setTintColor:)];
}

- (UIColor *)app_tintColor {
    return [self cachedParamForSelector:@selector(setTintColor:)];
}

- (void)setApp_Image:(UIImage *)image forSegmentAtIndex:(NSUInteger)segment {
    [self cacheThemeParams:@[image, @(segment)] forSelector:@selector(setImage:forSegmentAtIndex:)];
}

- (void)setApp_BackgroundImage:(UIImage *)backgroundImage
                      forState:(UIControlState)state barMetrics:(UIBarMetrics)barMetrics {
    [self cacheThemeParams:@[backgroundImage, @(state), @(barMetrics)]
               forSelector:@selector(setBackgroundImage:forState:barMetrics:)];
}

- (void)setApp_DividerImage:(UIImage *)dividerImage
        forLeftSegmentState:(UIControlState)leftState
          rightSegmentState:(UIControlState)rightState
                 barMetrics:(UIBarMetrics)barMetrics {
    [self cacheThemeParams:@[dividerImage, @(leftState), @(rightState), @(barMetrics)]
               forSelector:@selector(setDividerImage:forLeftSegmentState:rightSegmentState:barMetrics:)];
}

@end
