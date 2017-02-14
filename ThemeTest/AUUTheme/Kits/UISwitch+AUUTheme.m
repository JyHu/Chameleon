//
//  UISwitch+AUUTheme.m
//  ThemeTest
//
//  Created by JyHu on 2017/2/14.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "UISwitch+AUUTheme.h"
#import "NSObject+AUUTheme.h"
#import "NSString+_AUUPrivateHelper.h"
#import "AUUThemeManager.h"

@implementation UISwitch (AUUTheme)

- (void)setTintColorWithIdentifier:(NSString *)tintColorIdentifier
{
    [self cacheParams:@[tintColorIdentifier.colorType] forSelector:NSStringFromSelector(@selector(setTintColor:))];
}

- (void)setOnTintColorWithIdentifier:(NSString *)onTintColorIdentifier
{
    [self cacheParams:@[onTintColorIdentifier.colorType] forSelector:NSStringFromSelector(@selector(setOnTintColor:))];
}

- (void)setThumbTintColorWithIdentifier:(NSString *)thumbTintColorIdentifier
{
    [self cacheParams:@[thumbTintColorIdentifier.colorType] forSelector:NSStringFromSelector(@selector(setThumbTintColor:))];
}

- (void)setOnImageWithIdentifier:(NSString *)onImageIdentifier
{
    [self cacheParams:@[onImageIdentifier.imageType] forSelector:NSStringFromSelector(@selector(setOnImage:))];
}

- (void)setOffImageWithIdentifier:(NSString *)offImageIdentifier
{
    [self cacheParams:@[offImageIdentifier.imageType] forSelector:NSStringFromSelector(@selector(setOffImage:))];
}

- (void)dealloc
{
    self.notificationRegistered = NO;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:[AUUThemeManager sharedManager].changeThemeNotification object:nil];
}


@end
