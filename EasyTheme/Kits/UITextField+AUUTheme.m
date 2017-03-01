//
//  UITextField+AUUTheme.m
//  ThemeTest
//
//  Created by JyHu on 2017/2/14.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "UITextField+AUUTheme.h"
#import "NSObject+AUUTheme.h"

@implementation UITextField (AUUTheme)

- (void)setTintColorIdentifier:(NSString *)tintColorIdentifier
{
    [self cacheThemeParams:@[tintColorIdentifier.colorType] forSelector:@selector(setTintColor:)];
}

- (NSString *)tintColorIdentifier
{
    return [[[self cachedParamsForSelector:@selector(setTintColor:)] firstObject] firstObject] ?: AUUNoneIdentifierTips;
}

- (void)setTextColorIdentifier:(NSString *)textColorIdentifier
{
    [self cacheThemeParams:@[textColorIdentifier.colorType] forSelector:@selector(setTextColor:)];
}

- (NSString *)textColorIdentifier
{
    return [[[self cachedParamsForSelector:@selector(setTextColor:)] firstObject] firstObject] ?: AUUNoneIdentifierTips;
}

- (void)setBackgroundIdentifier:(NSString *)backgroundIdentifier
{
    [self cacheThemeParams:@[backgroundIdentifier.imageType] forSelector:@selector(setBackground:)];
}

- (NSString *)backgroundIdentifier
{
    return [[[self cachedParamsForSelector:@selector(setBackground:)] firstObject] firstObject] ?: AUUNoneIdentifierTips;
}

- (void)setDisabledBackgroundIdentifier:(NSString *)disabledBackgroundIdentifier
{
    [self cacheThemeParams:@[disabledBackgroundIdentifier.imageType] forSelector:@selector(setDisabledBackground:)];
}

- (NSString *)disabledBackgroundIdentifier
{
    return [[[self cachedParamsForSelector:@selector(setDisabledBackground:)] firstObject] firstObject] ?: AUUNoneIdentifierTips;
}
     
- (void)dealloc
{
    self.notificationRegistered = NO;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:[AUUThemeManager sharedManager].changeThemeNotification object:nil];
}

@end
