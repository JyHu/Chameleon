//
//  UIImageView+APPAppearance.m
//  DynamicTheme
//
//  Created by 胡金友 on 2018/3/23.
//

#import "UIImageView+APPAppearance.h"
#import "NSObject+APPAppearance.h"

@implementation UIImageView (APPAppearance)

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

- (void)setApp_image:(UIImage *)app_image {
    APPImageParamAssert(app_image)
    [self cacheThemeParams:@[app_image] forSelector:@selector(setImage:)];
}

- (UIImage *)app_image {
    return [self cachedParamForSelector:@selector(setImage:)];
}

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

- (void)setApp_highlightedImage:(UIImage *)app_highlightedImage {
    APPImageParamAssert(app_highlightedImage)
    [self cacheThemeParams:@[app_highlightedImage] forSelector:@selector(setHighlightedImage:)];
}

- (UIImage *)app_highlightedImage {
    return [self cachedParamForSelector:@selector(setHighlightedImage:)];
}

// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% //

@end
