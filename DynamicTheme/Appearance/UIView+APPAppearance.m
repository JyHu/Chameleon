//
//  UIView+APPAppearance.m
//  DynamicTheme
//
//  Created by 胡金友 on 2018/3/23.
//

#import "UIView+APPAppearance.h"
#import "NSObject+APPAppearance.h"

@implementation UIView (APPAppearance)

- (void)setApp_backgroundColor:(UIColor *)app_backgroundColor {
    APPColorParamAssert(app_backgroundColor)
    [self cacheThemeParams:@[app_backgroundColor] forSelector:@selector(setBackgroundColor:)];
}

- (UIColor *)app_backgroundColor {
    return [self cachedParamForSelector:@selector(setBackgroundColor:)];
}


- (void)setApp_layerBackgroundColor:(UIColor *)app_layerBackgroundColor {
    APPColorParamAssert(app_layerBackgroundColor)
    [self cacheThemeParams:@[app_layerBackgroundColor] forSelector:@selector(setLayerBackgroundColor:)];
}

- (UIColor *)app_layerBackgroundColor {
    return [self cachedParamForSelector:@selector(setLayerBackgroundColor:)];
}

- (void)setLayerBackgroundColor:(UIColor *)color {
    self.layer.backgroundColor = color.CGColor;
}

@end
