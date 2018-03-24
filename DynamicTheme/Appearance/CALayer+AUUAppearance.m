//
//  CALayer+AUUAppearance.m
//  DynamicTheme
//
//  Created by 胡金友 on 2018/3/24.
//

#import "CALayer+AUUAppearance.h"
#import "NSObject+APPAppearance.h"

@implementation CALayer (AUUAppearance)

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

- (void)setApp_backgroundColor:(UIColor *)app_backgroundColor {
    APPColorParamAssert(app_backgroundColor);
    [self cacheThemeParams:@[app_backgroundColor] forSelector:@selector(setupLayerBackgroundColor:)];
}

- (UIColor *)app_backgroundColor {
    return [self cachedParamForSelector:@selector(setupLayerBackgroundColor:)];
}

- (void)setupLayerBackgroundColor:(UIColor *)color {
    if (color) {
        self.backgroundColor = color.CGColor;
    }
}

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

- (void)setApp_borderColor:(UIColor *)app_borderColor {
    APPColorParamAssert(app_borderColor)
    [self cacheThemeParams:@[app_borderColor] forSelector:@selector(setBorderColor:)];
}

- (UIColor *)app_borderColor {
    return [self cachedParamForSelector:@selector(setBorderColor:)];
}

- (void)setupLayerBorderColor:(UIColor *)color {
    if (color) {
        self.borderColor = color.CGColor;
    }
}

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

@end
