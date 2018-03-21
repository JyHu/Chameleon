//
//  UIButton+AUUTheme.m
//  ThemeTest
//
//  Created by JyHu on 2017/2/14.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "UIButton+AUUTheme.h"
#import "NSObject+AUUTheme.h"

@implementation UIButton (AUUTheme)

- (void)setApp_TitleColor:(UIColor *)color forState:(UIControlState)state {
    NSAssert(color, @"Button标题颜色设置不能为空");
    [self cacheThemeParams:@[color, @(state)] forSelector:@selector(setTitleColor:forState:)];
}

- (void)setApp_Image:(UIImage *)image forState:(UIControlState)state {
    NSAssert(image, @"Button状态图片设置不能为空");
    [self cacheThemeParams:@[image, @(state)] forSelector:@selector(setImage:forState:)];
}

- (void)setApp_BackgroundImage:(UIImage *)image forState:(UIControlState)state {
    NSAssert(image, @"Button背景图片设置不能为空");
    [self cacheThemeParams:@[image, @(state)] forSelector:@selector(setApp_BackgroundImage:forState:)];
}

@end
