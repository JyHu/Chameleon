//
//  UIButton+AUUTheme.m
//  ThemeTest
//
//  Created by JyHu on 2017/2/14.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "UIButton+AUUTheme.h"
#import "NSObject+AUUTheme.h"
#import "NSString+_AUUPrivateHelper.h"
#import "AUUThemeManager.h"

@implementation UIButton (AUUTheme)

- (void)setTitleColorWithIdentifier:(NSString *)identifier forState:(UIControlState)state
{    
    [self cacheParams:@[identifier.colorType, @(state)] forSelector:NSStringFromSelector(@selector(setTitleColor:forState:))];
}

- (void)setImageWithIdentifier:(NSString *)identifier forState:(UIControlState)state
{
    [self cacheParams:@[identifier.imageType, @(state)] forSelector:NSStringFromSelector(@selector(setImage:forState:))];
}

- (void)setBackgroundImageWithIdentifier:(NSString *)identifier forState:(UIControlState)state
{
    [self cacheParams:@[identifier.imageType, @(state)] forSelector:NSStringFromSelector(@selector(setBackgroundImage:forState:))];
}

- (void)dealloc
{
    self.notificationRegistered = NO;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:[AUUThemeManager sharedManager].changeThemeNotification object:nil];
}

@end
