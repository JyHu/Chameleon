//
//  UITextView+AUUTheme.m
//  ThemeTest
//
//  Created by JyHu on 2017/2/14.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "UITextView+AUUTheme.h"
#import "NSObject+AUUTheme.h"

@implementation UITextView (AUUTheme)

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
    return [[[self cachedParamsForSelector:@selector(setTintColor:)] firstObject] firstObject] ?: AUUNoneIdentifierTips;
}

- (void)dealloc
{
    self.notificationRegistered = NO;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:[AUUThemeManager sharedManager].changeThemeNotification object:nil];
}

@end
