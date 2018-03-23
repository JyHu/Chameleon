//
//  UITextView+APPAppearance.m
//  DynamicTheme
//
//  Created by 胡金友 on 2018/3/23.
//

#import "UITextView+APPAppearance.h"
#import "NSObject+APPAppearance.h"

@implementation UITextView (APPAppearance)

- (void)setApp_tintColor:(UIColor *)app_tintColor {
    APPColorParamAssert(app_tintColor)
    [self cacheThemeParams:@[app_tintColor] forSelector:@selector(setTintColor:)];
}

- (UIColor *)app_tintColor {
    return [self cachedParamForSelector:@selector(setTintColor:)];
}

- (void)setApp_textColor:(UIColor *)app_textColor {
    APPColorParamAssert(app_textColor)
    [self cacheThemeParams:@[app_textColor] forSelector:@selector(setTextColor:)];
}

- (UIColor *)app_textColor {
    return [self cachedParamForSelector:@selector(setTextColor:)];
}

@end
