//
//  UITableView+AUUTheme.m
//  ThemeTest
//
//  Created by JyHu on 2017/2/26.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "UITableView+AUUTheme.h"
#import "NSObject+AUUTheme.h"

@implementation UITableView (AUUTheme)

- (void)setApp_separatorColor:(UIColor *)app_separatorColor {
    [self cacheThemeParams:@[app_separatorColor] forSelector:@selector(setSeparatorColor:)];
}

- (UIColor *)app_separatorColor {
    return [self cachedParamForSelector:@selector(setSeparatorColor:)];
}

@end
