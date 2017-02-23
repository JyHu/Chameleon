//
//  UIButton+AUUTheme.m
//  ThemeTest
//
//  Created by JyHu on 2017/2/14.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "UIButton+AUUTheme.h"
#import "NSObject+AUUTheme.h"
#import "NSString+AUUTheme.h"
#import "AUUThemeManager.h"

@implementation UIButton (AUUTheme)

- (void)setTitleColorWithIdentifier:(NSString *)identifier forState:(UIControlState)state
{    
    [self cacheParams:@[identifier.colorType, @(state)]
          forSelector:@selector(setTitleColor:forState:)];
}

- (NSArray *)titleColorIdentifiers
{
    return [self cachedParamsForSelector:@selector(setTitleColor:forState:)] ?: AUUNoneIdentifierTips;
}

- (void)setImageWithIdentifier:(NSString *)identifier forState:(UIControlState)state
{
    [self cacheParams:@[identifier.imageType, @(state)] forSelector:@selector(setImage:forState:)];
}

- (NSArray *)imageIdentifiers
{
    return [self cachedParamsForSelector:@selector(setImage:forState:)] ?: AUUNoneIdentifierTips;
}

- (void)setBackgroundImageWithIdentifier:(NSString *)identifier forState:(UIControlState)state
{
    [self cacheParams:@[identifier.imageType, @(state)] forSelector:@selector(setBackgroundImage:forState:)];
}

- (NSArray *)backgroundImageIdentifiers
{
    return [self cachedParamsForSelector:@selector(setBackgroundImage:forState:)] ?: AUUNoneIdentifierTips;
}

- (void)dealloc
{
    self.notificationRegistered = NO;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:[AUUThemeManager sharedManager].changeThemeNotification object:nil];
}

@end
