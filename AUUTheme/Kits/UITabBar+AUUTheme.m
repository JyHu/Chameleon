//
//  UITabBar+AUUTheme.m
//  ThemeTest
//
//  Created by 胡金友 on 2017/2/23.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "UITabBar+AUUTheme.h"
#import "NSObject+AUUTheme.h"

@implementation UITabBar (AUUTheme)

- (void)setTintColorIdentifier:(NSString *)tintColorIdentifier
{
    [self cacheParams:@[tintColorIdentifier.colorType] forSelector:@selector(setTintColor:)];
}

- (NSString *)tintColorIdentifier
{
    return [[[self cachedParamsForSelector:@selector(setTintColor:)] firstObject] firstObject] ?: AUUNoneIdentifierTips;
}

- (void)setBarTintColorIdentifier:(NSString *)barTintColorIdentifier
{
    [self cacheParams:@[barTintColorIdentifier.colorType] forSelector:@selector(setBarTintColor:)];
}

- (NSString *)barTintColorIdentifier
{
    return [[[self cachedParamsForSelector:@selector(setBarTintColor:)] firstObject] firstObject] ?: AUUNoneIdentifierTips;
}

- (void)setUnselectedItemTintColorIdentifier:(NSString *)unselectedItemTintColorIdentifier
{
    [self cacheParams:@[unselectedItemTintColorIdentifier.colorType] forSelector:@selector(setUnselectedItemTintColor:)];
}

- (NSString *)unselectedItemTintColorIdentifier
{
    return [[[self cachedParamsForSelector:@selector(setUnselectedItemTintColor:)] firstObject] firstObject] ?: AUUNoneIdentifierTips;
}

- (void)setSelectedImageTintColorIdentifier:(NSString *)selectedImageTintColorIdentifier
{
    [self cacheParams:@[selectedImageTintColorIdentifier.colorType] forSelector:@selector(setSelectedImageTintColor:)];
}

- (NSString *)selectedImageTintColorIdentifier
{
    return [[[self cachedParamsForSelector:@selector(setSelectedImageTintColor:)] firstObject] firstObject] ?: AUUNoneIdentifierTips;
}

- (void)setBackgroundImageIdentifier:(NSString *)backgroundImageIdentifier
{
    [self cacheParams:@[backgroundImageIdentifier.imageType] forSelector:@selector(setBackgroundImage:)];
}

- (NSString *)backgroundImageIdentifier
{
    return [[[self cachedParamsForSelector:@selector(setBackgroundImage:)] firstObject] firstObject] ?: AUUNoneIdentifierTips;
}

- (void)setSelectionIndicatorImageIdentifier:(NSString *)selectionIndicatorImageIdentifier
{
    [self cacheParams:@[selectionIndicatorImageIdentifier.imageType] forSelector:@selector(setSelectionIndicatorImage:)];
}

- (NSString *)selectionIndicatorImageIdentifier
{
    return [[[self cachedParamsForSelector:@selector(setSelectionIndicatorImage:)] firstObject] firstObject] ?: AUUNoneIdentifierTips;
}

- (void)setShadowImageIdentifier:(NSString *)shadowImageIdentifier
{
    [self cacheParams:@[shadowImageIdentifier.imageType] forSelector:@selector(setShadowImage:)];
}

- (NSString *)shadowImageIdentifier
{
    return [[[self cachedParamsForSelector:@selector(setShadowImage:)] firstObject] firstObject] ?: AUUNoneIdentifierTips;
}

- (void)dealloc
{
    self.notificationRegistered = NO;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:[AUUThemeManager sharedManager].changeThemeNotification object:nil];
}

@end
