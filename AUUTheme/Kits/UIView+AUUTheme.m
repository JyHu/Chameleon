//
//  UIView+AUUTheme.m
//  ThemeTest
//
//  Created by JyHu on 2017/2/14.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "UIView+AUUTheme.h"
#import "NSObject+AUUTheme.h"

@implementation UIView (AUUTheme)

- (void)setBackgroundColorIdentifier:(NSString *)backgroundColorIdentifier
{
    [self cacheParams:@[backgroundColorIdentifier.colorType] forSelector:@selector(setBackgroundColor:)];
    
    [self cacheParams:@[] forSelector:@selector(self) argTransfer:^id(id object, SEL sel, id arg, NSUInteger argIndex, BOOL *skip) {
        return nil;
    }];
}

- (NSString *)backgroundColorIdentifier
{
    return [[[self cachedParamsForSelector:@selector(setBackgroundColor:)] firstObject] firstObject] ?: AUUNoneIdentifierTips;
}

- (void)dealloc
{
    self.notificationRegistered = NO;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:[AUUThemeManager sharedManager].changeThemeNotification object:nil];
}

@end
