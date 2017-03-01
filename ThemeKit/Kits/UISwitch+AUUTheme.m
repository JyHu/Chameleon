//
//  UISwitch+AUUTheme.m
//  ThemeTest
//
//  Created by JyHu on 2017/2/14.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "UISwitch+AUUTheme.h"
#import "NSObject+AUUTheme.h"

@implementation UISwitch (AUUTheme)

- (void)setTintColorIdentifier:(NSString *)tintColorIdentifier
{
    [self cacheThemeParams:@[tintColorIdentifier.colorType] forSelector:@selector(setTintColor:)];
}

- (NSString *)tintColorIdentifier
{
    return [[[self cachedParamsForSelector:@selector(setTintColor:)] firstObject] firstObject] ?: AUUNoneIdentifierTips;
}

- (void)setOnTintColorIdentifier:(NSString *)onTintColorIdentifier
{
    [self cacheThemeParams:@[onTintColorIdentifier.colorType] forSelector:@selector(setOnTintColor:)];
}

- (NSString *)onTintColorIdentifier
{
    return [[[self cachedParamsForSelector:@selector(setOnTintColor:)] firstObject] firstObject] ?: AUUNoneIdentifierTips;
}

- (void)setThumbTintColorIdentifier:(NSString *)thumbTintColorIdentifier
{
    [self cacheThemeParams:@[thumbTintColorIdentifier.colorType] forSelector:@selector(setThumbTintColor:)];
}

- (NSString *)thumbTintColorIdentifier
{
    return [[[self cachedParamsForSelector:@selector(setThumbTintColor:)] firstObject] firstObject] ?: AUUNoneIdentifierTips;
}

- (void)setOnImageIdentifier:(NSString *)onImageIdentifier
{
    [self cacheThemeParams:@[onImageIdentifier.imageType] forSelector:@selector(setOnImage:)];
}

- (NSString *)onImageIdentifier
{
    return [[[self cachedParamsForSelector:@selector(setOnImage:)] firstObject] firstObject] ?: AUUNoneIdentifierTips;
}

- (void)setOffImageIdentifier:(NSString *)offImageIdentifier
{
    [self cacheThemeParams:@[offImageIdentifier.imageType] forSelector:@selector(setOffImage:)];
}

- (NSString *)offImageIdentifier
{
    return [[[self cachedParamsForSelector:@selector(setOffImage:)] firstObject] firstObject] ?: AUUNoneIdentifierTips;
}

- (void)dealloc
{
    self.notificationRegistered = NO;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:[AUUThemeManager sharedManager].changeThemeNotification object:nil];
}


@end
