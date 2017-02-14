//
//  UITextView+AUUTheme.m
//  ThemeTest
//
//  Created by JyHu on 2017/2/14.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "UITextView+AUUTheme.h"
#import "NSObject+AUUTheme.h"
#import "NSString+_AUUPrivateHelper.h"
#import "AUUThemeManager.h"

@implementation UITextView (AUUTheme)

- (void)setTintColorWithIdentifier:(NSString *)tintColorIdentifier
{
    [self cacheParams:@[tintColorIdentifier.colorType] forSelector:NSStringFromSelector(@selector(setTintColor:))];
}

- (void)setTextColorWithIdentifier:(NSString *)textColorIdentifier
{
    [self cacheParams:@[textColorIdentifier.colorType] forSelector:NSStringFromSelector(@selector(setTextColor:))];
}

- (void)dealloc
{
    self.notificationRegistered = NO;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:[AUUThemeManager sharedManager].changeThemeNotification object:nil];
}

@end
