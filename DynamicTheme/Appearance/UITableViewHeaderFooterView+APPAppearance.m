//
//  UITableViewHeaderFooterView+APPAppearance.m
//  DynamicTheme
//
//  Created by 胡金友 on 2018/3/23.
//

#import "UITableViewHeaderFooterView+APPAppearance.h"
#import "NSObject+APPAppearance.h"

@implementation UITableViewHeaderFooterView (APPAppearance)

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

- (void)setApp_tintColor:(UIColor *)app_tintColor {
    APPColorParamAssert(app_tintColor)
    [self cacheThemeParams:@[app_tintColor] forSelector:@selector(setTintColor:)];
}

- (UIColor *)app_tintColor {
    return [self cachedParamForSelector:@selector(setTintColor:)];
}

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

@end
