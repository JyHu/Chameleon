//
//  UIButton+APPAppearance.m
//  DynamicTheme
//
//  Created by 胡金友 on 2018/3/23.
//

#import "UIButton+APPAppearance.h"
#import "NSObject+APPAppearance.h"

@implementation UIButton (APPAppearance)

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

- (void)setApp_TitleColor:(UIColor *)color forState:(UIControlState)state {
    APPColorParamAssert(color)
    [self cacheThemeParams:@[color, @(state)] forSelector:@selector(setTitleColor:forState:)];
}

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

- (void)setApp_Image:(UIImage *)image forState:(UIControlState)state {
    APPImageParamAssert(image)
    [self cacheThemeParams:@[image, @(state)] forSelector:@selector(setImage:forState:)];
}

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

- (void)setApp_BackgroundImage:(UIImage *)image forState:(UIControlState)state {
    APPImageParamAssert(image)
    [self cacheThemeParams:@[image, @(state)] forSelector:@selector(setBackgroundImage:forState:)];
}

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

@end
