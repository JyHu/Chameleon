//
//  UILabel+AUUTheme.m
//  ThemeTest
//
//  Created by JyHu on 2017/2/14.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "UILabel+AUUTheme.h"
#import "NSObject+AUUTheme.h"
#import "NSString+_AUUPrivateHelper.h"
#import "AUUThemeManager.h"

@implementation UILabel (AUUTheme)

- (void)setTextColorWithIdentifier:(NSString *)identifier
{    
    [self cacheParams:@[identifier.colorType] forSelector:NSStringFromSelector(@selector(setTextColor:))];
}

- (void)dealloc
{
    self.notificationRegistered = NO;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:[AUUThemeManager sharedManager].changeThemeNotification object:nil];
}


@end
