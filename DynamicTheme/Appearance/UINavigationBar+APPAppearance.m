//
//  UINavigationBar+APPAppearance.m
//  DynamicTheme
//
//  Created by 胡金友 on 2018/3/23.
//

#import "UINavigationBar+APPAppearance.h"
#import "NSObject+APPAppearance.h"

@implementation UINavigationBar (APPAppearance)

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

- (void)setApp_titleColor:(UIColor *)app_titleColor {
    APPColorParamAssert(app_titleColor)
    [self cacheThemeParams:@[app_titleColor] forSelector:@selector(_setNavibarTitleColor:)];
}

- (UIColor *)app_titleColor {
    return [self cachedParamForSelector:@selector(_setNavibarTitleColor:)];
}

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

- (void)setApp_BackgroundImage:(UIImage *)image forBarMetrics:(UIBarMetrics)barMetrics {
    APPImageParamAssert(image)
    [self cacheThemeParams:@[image, @(barMetrics)] forSelector:@selector(setBackgroundImage:forBarMetrics:)];
}

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

- (void)_setNavibarTitleColor:(UIColor *)titleColor {
    NSMutableDictionary *titleAttributes = [self.titleTextAttributes mutableCopy];
    if (titleColor) {
        [titleAttributes setObject:titleColor forKey:NSForegroundColorAttributeName];
        self.titleTextAttributes = titleAttributes;
    }
}

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

@end
