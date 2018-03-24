//
//  UIView+APPAppearance.m
//  DynamicTheme
//
//  Created by 胡金友 on 2018/3/23.
//

#import "UIView+APPAppearance.h"
#import "NSObject+APPAppearance.h"

@implementation UIView (APPAppearance)

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

- (void)setApp_backgroundColor:(UIColor *)app_backgroundColor {
    APPColorParamAssert(app_backgroundColor)
    [self cacheThemeParams:@[app_backgroundColor] forSelector:@selector(setBackgroundColor:)];
}

- (UIColor *)app_backgroundColor {
    return [self cachedParamForSelector:@selector(setBackgroundColor:)];
}

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

@end
