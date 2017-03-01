//
//  UITableView+AUUTheme.m
//  ThemeTest
//
//  Created by JyHu on 2017/2/26.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "UITableView+AUUTheme.h"
#import "NSObject+AUUTheme.h"

@implementation UITableView (AUUTheme)

- (void)setSeparatorColorIdentifier:(NSString *)separatorColorIdentifier
{
    [self cacheThemeParams:@[separatorColorIdentifier.colorType] forSelector:@selector(setSeparatorColor:)];
}

- (NSString *)separatorColorIdentifier
{
    return [[[self cachedParamsForSelector:@selector(setSeparatorColor:)] firstObject] firstObject] ?: AUUNoneIdentifierTips;
}

- (void)dealloc
{
    self.notificationRegistered = NO;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:[AUUThemeManager sharedManager].changeThemeNotification object:nil];
}

@end
