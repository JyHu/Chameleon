//
//  UILabel+AUUTheme.m
//  ThemeTest
//
//  Created by JyHu on 2017/2/14.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "UILabel+AUUTheme.h"
#import "NSObject+AUUTheme.h"

@implementation UILabel (AUUTheme)

- (void)setApp_textColor:(UIColor *)app_textColor {
    [self cacheThemeParams:@[app_textColor] forSelector:@selector(setTextColor:)];
}

- (UIColor *)app_textColor {
    return [self cachedParamForSelector:@selector(setTextColor:)];
}

@end
