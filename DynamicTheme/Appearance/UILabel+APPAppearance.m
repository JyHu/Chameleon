//
//  UILabel+APPAppearance.m
//  DynamicTheme
//
//  Created by 胡金友 on 2018/3/23.
//

#import "UILabel+APPAppearance.h"
#import "NSObject+APPAppearance.h"

@implementation UILabel (APPAppearance)

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

- (void)setApp_textColor:(UIColor *)app_textColor {
    APPColorParamAssert(app_textColor)
    [self cacheThemeParams:@[app_textColor] forSelector:@selector(setTextColor:)];
}

- (UIColor *)app_textColor {
    return [self cachedParamForSelector:@selector(setTextColor:)];
}

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

@end
