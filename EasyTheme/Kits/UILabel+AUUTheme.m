//
//  UILabel+AUUTheme.m
//  ThemeTest
//
//  Created by JyHu on 2017/2/14.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "UILabel+AUUTheme.h"
#import "NSObject+AUUTheme.h"

@implementation UILabel (AUUTheme)

- (void)setTextColorIdentifier:(NSString *)textColorIdentifier
{    
    [self cacheThemeParams:@[textColorIdentifier.colorType] forSelector:@selector(setTextColor:)];
}

- (NSString *)textColorIdentifier
{
    return [[[self cachedParamsForSelector:@selector(setTextColor:)] firstObject] firstObject] ?: AUUNoneIdentifierTips;
}

- (void)dealloc
{
    self.notificationRegistered = NO;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:[AUUThemeManager sharedManager].changeThemeNotification object:nil];
}


@end
