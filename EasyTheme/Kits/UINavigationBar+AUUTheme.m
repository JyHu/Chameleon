//
//  UINavigationBar+AUUTheme.m
//  ThemeTest
//
//  Created by JyHu on 2017/2/25.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "UINavigationBar+AUUTheme.h"
#import "NSObject+AUUTheme.h"

@implementation UINavigationBar (AUUTheme)

- (void)setTitleColorIdentifier:(NSString *)titleColorIdentifier
{
    [self cacheThemeParams:@[titleColorIdentifier.colorType] forSelector:@selector(_setNavibarTitleColor:)];
}

- (NSString *)titleColorIdentifier
{
    return [[[self cachedParamsForSelector:@selector(_setNavibarTitleColor:)] firstObject] firstObject] ?: AUUNoneIdentifierTips;
}

- (void)setBackgroundImageIdentifier:(NSString *)backgroundImageIdentifier forBarMetrics:(UIBarMetrics)barMetrics
{
    [self cacheThemeParams:@[backgroundImageIdentifier.imageType, @(barMetrics)] forSelector:@selector(setBackgroundImage:forBarMetrics:)];
}

- (void)_setNavibarTitleColor:(UIColor *)titleColor
{
    NSMutableDictionary *titleAttributes = [self.titleTextAttributes mutableCopy];
    
    if (titleColor)
    {
        [titleAttributes setObject:titleColor forKey:NSForegroundColorAttributeName];
        
        self.titleTextAttributes = titleAttributes;
    }
}

- (void)dealloc
{
    self.notificationRegistered = NO;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:[AUUThemeManager sharedManager].changeThemeNotification object:nil];
}

@end
