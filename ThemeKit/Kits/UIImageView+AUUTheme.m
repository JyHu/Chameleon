//
//  UIImageView+AUUTheme.m
//  ThemeTest
//
//  Created by JyHu on 2017/2/14.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "UIImageView+AUUTheme.h"
#import "NSObject+AUUTheme.h"

@implementation UIImageView (AUUTheme)

- (void)setApp_image:(UIImage *)app_image {
    [self cacheThemeParams:@[app_image] forSelector:@selector(setImage:)];
}

- (void)setApp_highlightedImage:(UIImage *)app_highlightedImage {
    [self cacheThemeParams:@[app_highlightedImage] forSelector:@selector(setHighlightedImage:)];
}

@end
