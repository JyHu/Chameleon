//
//  UITableViewHeaderFooterView+AUUTheme.m
//  ThemeTest
//
//  Created by 胡金友 on 2017/2/23.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "UITableViewHeaderFooterView+AUUTheme.h"
#import "NSObject+AUUTheme.h"

@implementation UITableViewHeaderFooterView (AUUTheme)

- (void)setApp_tintColor:(UIColor *)app_tintColor {
    [self cacheThemeParams:@[app_tintColor] forSelector:@selector(setTintColor:)];
}

- (UIColor *)app_tintColor {
    return [self cachedParamForSelector:@selector(setTintColor:)];
}

@end
