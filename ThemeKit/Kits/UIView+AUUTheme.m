//
//  UIView+AUUTheme.m
//  ThemeTest
//
//  Created by JyHu on 2017/2/14.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "UIView+AUUTheme.h"
#import "NSObject+AUUTheme.h"

@implementation UIView (AUUTheme)

@dynamic app_backgroundColor;
@dynamic app_layerBackgroundColor;

- (void)setApp_backgroundColor:(UIColor *)app_backgroundColor {
    [self cacheThemeParams:@[app_backgroundColor] forSelector:@selector(setBackgroundColor:)];
}



- (void)setApp_layerBackgroundColor:(UIColor *)app_layerBackgroundColor {
    [self cacheThemeParams:@[app_layerBackgroundColor] forSelector:@selector(setLayerBackgroundColor:)];
}

- (void)setLayerBackgroundColor:(UIColor *)color {
    self.layer.backgroundColor = color.CGColor;
}

@end
