//
//  UISegmentedControl+APPAppearance.m
//  DynamicTheme
//
//  Created by 胡金友 on 2018/3/23.
//

#import "UISegmentedControl+APPAppearance.h"
#import "NSObject+APPAppearance.h"

@implementation UISegmentedControl (APPAppearance)

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

- (void)setApp_tintColor:(UIColor *)app_tintColor {
    APPColorParamAssert(app_tintColor)
    [self cacheThemeParams:@[app_tintColor] forSelector:@selector(setTintColor:)];
}

- (UIColor *)app_tintColor {
    return [self cachedParamForSelector:@selector(setTintColor:)];
}

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

- (void)setApp_Image:(UIImage *)image forSegmentAtIndex:(NSUInteger)segment {
    APPImageParamAssert(image)
    [self cacheThemeParams:@[image, @(segment)] forSelector:@selector(setImage:forSegmentAtIndex:)];
}

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

- (void)setApp_BackgroundImage:(UIImage *)backgroundImage
                      forState:(UIControlState)state
                    barMetrics:(UIBarMetrics)barMetrics {
    APPImageParamAssert(backgroundImage)
    [self cacheThemeParams:@[backgroundImage, @(state), @(barMetrics)]
               forSelector:@selector(setBackgroundImage:forState:barMetrics:)];
}

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

- (void)setApp_DividerImage:(UIImage *)dividerImage
        forLeftSegmentState:(UIControlState)leftState
          rightSegmentState:(UIControlState)rightState
                 barMetrics:(UIBarMetrics)barMetrics {
    APPImageParamAssert(dividerImage)
    [self cacheThemeParams:@[dividerImage, @(leftState), @(rightState), @(barMetrics)]
               forSelector:@selector(setDividerImage:forLeftSegmentState:rightSegmentState:barMetrics:)];
}

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

@end
