//
//  UITextField+APPAppearance.m
//  DynamicTheme
//
//  Created by 胡金友 on 2018/3/23.
//

#import "UITextField+APPAppearance.h"
#import "NSObject+APPAppearance.h"

@implementation UITextField (APPAppearance)

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

- (void)setApp_tintColor:(UIColor *)app_tintColor {
    APPColorParamAssert(app_tintColor)
    [self cacheThemeParams:@[app_tintColor] forSelector:@selector(setTintColor:)];
}

- (UIColor *)app_tintColor {
    return [self cachedParamForSelector:@selector(setTintColor:)];
}

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

- (void)setApp_textColor:(UIColor *)app_textColor {
    APPColorParamAssert(app_textColor)
    [self cacheThemeParams:@[app_textColor] forSelector:@selector(setTextColor:)];
}

- (UIColor *)app_textColor {
    return [self cachedParamForSelector:@selector(setTextColor:)];
}

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

- (void)setApp_background:(UIImage *)app_background {
    APPImageParamAssert(app_background)
    [self cacheThemeParams:@[app_background] forSelector:@selector(setBackground:)];
}

- (UIImage *)app_background {
    return [self cachedParamForSelector:@selector(setBackground:)];
}

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

- (void)setApp_disabledBackground:(UIImage *)app_disabledBackground {
    APPImageParamAssert(app_disabledBackground)
    [self cacheThemeParams:@[app_disabledBackground] forSelector:@selector(setDisabledBackground:)];
}

- (UIImage *)app_disabledBackground {
    return [self cachedParamForSelector:@selector(setDisabledBackground:)];
}

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

@end
