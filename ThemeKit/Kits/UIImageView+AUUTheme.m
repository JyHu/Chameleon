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

- (void)setImageIdentifier:(NSString *)imageIdentifier
{
    [self cacheThemeParams:@[imageIdentifier.imageType] forSelector:@selector(setImage:)];
}

- (NSString *)imageIdentifier
{
    return [[[self cachedParamsForSelector:@selector(setImage:)] firstObject] firstObject] ?: AUUNoneIdentifierTips;
}

- (void)setHighlightedImageIdentifier:(NSString *)highlightedImageIdentifier
{
    [self cacheThemeParams:@[highlightedImageIdentifier.imageType] forSelector:@selector(setHighlightedImage:)];
}

- (NSString *)highlightedImageIdentifier
{
    return [[[self cachedParamsForSelector:@selector(setHighlightedImage:)] firstObject] firstObject] ?: AUUNoneIdentifierTips;
}

- (void)setImageColorIdentifier:(NSString *)colorIdentifier
{
    [self cacheThemeParams:@[colorIdentifier.colorType] forSelector:@selector(setImageColor:)];
}

- (NSString *)imageColorIdentifier
{
    return [[[self cachedParamsForSelector:@selector(setImageColor:)] firstObject] firstObject] ?: AUUNoneIdentifierTips;
}

- (void)setImageColor:(UIColor *)color
{
    if (color)
    {
        self.image = [UIImage imageWithColor:color];
    }
}

- (void)dealloc
{
    self.notificationRegistered = NO;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:[AUUThemeManager sharedManager].changeThemeNotification object:nil];
}


@end
