//
//  UISwitch+APPAppearance.m
//  DynamicTheme
//
//  Created by 胡金友 on 2018/3/23.
//

#import "UISwitch+APPAppearance.h"
#import "NSObject+APPAppearance.h"

@implementation UISwitch (APPAppearance)

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

- (void)setApp_tintColor:(UIColor *)app_tintColor {
    APPColorParamAssert(app_tintColor)
    [self cacheThemeParams:@[app_tintColor] forSelector:@selector(setTintColor:)];
}

- (UIColor *)app_tintColor {
    return [self cachedParamForSelector:@selector(setTintColor:)];
}

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

- (void)setApp_onTintColor:(UIColor *)app_onTintColor {
    APPColorParamAssert(app_onTintColor)
    [self cacheThemeParams:@[app_onTintColor] forSelector:@selector(setOnTintColor:)];
}

- (UIColor *)app_onTintColor {
    return [self cachedParamForSelector:@selector(setOnTintColor:)];
}

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

- (void)setApp_thumbTintColor:(UIColor *)app_thumbTintColor {
    APPColorParamAssert(app_thumbTintColor)
    [self cacheThemeParams:@[app_thumbTintColor] forSelector:@selector(setThumbTintColor:)];
}

- (UIColor *)app_thumbTintColor {
    return [self cachedParamForSelector:@selector(setThumbTintColor:)];
}

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

- (void)setApp_onImage:(UIImage *)app_onImage {
    APPImageParamAssert(app_onImage)
    [self cacheThemeParams:@[app_onImage] forSelector:@selector(setOnImage:)];
}

- (UIImage *)app_onImage {
    return [self cachedParamForSelector:@selector(setOnImage:)];
}

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

- (void)setApp_offImage:(UIImage *)app_offImage {
    APPImageParamAssert(app_offImage)
    [self cacheThemeParams:@[app_offImage] forSelector:@selector(setOffImage:)];
}

- (UIImage *)app_offImage {
    return [self cachedParamForSelector:@selector(setOffImage:)];
}

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

@end
