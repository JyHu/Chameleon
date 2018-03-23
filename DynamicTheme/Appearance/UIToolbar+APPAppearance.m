//
//  UIToolbar+APPAppearance.m
//  DynamicTheme
//
//  Created by 胡金友 on 2018/3/23.
//

#import "UIToolbar+APPAppearance.h"
#import "NSObject+APPAppearance.h"

@implementation UIToolbar (APPAppearance)

- (void)setApp_tintColor:(UIColor *)app_tintColor {
    APPColorParamAssert(app_tintColor)
    [self cacheThemeParams:@[app_tintColor] forSelector:@selector(setTintColor:)];
}

- (UIColor *)app_tintColor {
    return [self cachedParamForSelector:@selector(setTintColor:)];
}

- (void)setApp_barTintColor:(UIColor *)app_barTintColor {
    APPColorParamAssert(app_barTintColor)
    [self cacheThemeParams:@[app_barTintColor] forSelector:@selector(setBarTintColor:)];
}

- (UIColor *)app_barTintColor {
    return [self cachedParamForSelector:@selector(setBarTintColor:)];
}

@end
