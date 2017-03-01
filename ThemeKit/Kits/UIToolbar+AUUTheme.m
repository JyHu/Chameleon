//
//  UIToolbar+AUUTheme.m
//  ThemeTest
//
//  Created by 胡金友 on 2017/2/23.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "UIToolbar+AUUTheme.h"
#import "NSObject+AUUTheme.h"

@implementation UIToolbar (AUUTheme)

- (void)setTintColorIdentifier:(NSString *)tintColorIdentifier
{
    [self cacheThemeParams:@[tintColorIdentifier.colorType] forSelector:@selector(setTintColor:)];
}

- (NSString *)tintColorIdentifier
{
    return [[[self cachedParamsForSelector:@selector(setTintColor:)] firstObject] firstObject] ?: AUUNoneIdentifierTips;
}

- (void)setBarTintColorIdentifier:(NSString *)barTintColorIdentifier
{
    [self cacheThemeParams:@[barTintColorIdentifier.colorType] forSelector:@selector(setBarTintColor:)];
}

- (NSString *)barTintColorIdentifier
{
    return [[[self cachedParamsForSelector:@selector(setBarTintColor:)] firstObject] firstObject] ?: AUUNoneIdentifierTips;
}

- (void)dealloc
{
    self.notificationRegistered = NO;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:[AUUThemeManager sharedManager].changeThemeNotification object:nil];
}


@end
