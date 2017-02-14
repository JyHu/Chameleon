//
//  UISegmentedControl+AUUTheme.m
//  ThemeTest
//
//  Created by JyHu on 2017/2/14.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "UISegmentedControl+AUUTheme.h"
#import "NSObject+AUUTheme.h"
#import "NSString+_AUUPrivateHelper.h"
#import "AUUThemeManager.h"

@implementation UISegmentedControl (AUUTheme)

- (void)setTintColorWithIdentifier:(NSString *)tintColorIdentifier
{
    [self cacheParams:@[tintColorIdentifier.colorType] forSelector:NSStringFromSelector(@selector(setTintColor:))];
}

- (void)setImageWithIdentifier:(NSString *)imageIdentifier forSegmentAtIndex:(NSUInteger)segment
{
    [self cacheParams:@[imageIdentifier.imageType, @(segment)]
          forSelector:NSStringFromSelector(@selector(setImage:forSegmentAtIndex:))];
}

- (void)setBackgroundImageWithIdentifier:(NSString *)backgroundImageIdentifier
                                forState:(UIControlState)state barMetrics:(UIBarMetrics)barMetrics
{
    [self cacheParams:@[backgroundImageIdentifier.imageType, @(state), @(barMetrics)]
          forSelector:NSStringFromSelector(@selector(setBackgroundImage:forState:barMetrics:))];
}

- (void)setDividerImageWithIdentifier:(NSString *)dividerImageIdentifier forLeftSegmentState:(UIControlState)leftState
                    rightSegmentState:(UIControlState)rightState barMetrics:(UIBarMetrics)barMetrics
{
    [self cacheParams:@[dividerImageIdentifier.imageType, @(leftState), @(rightState), @(barMetrics)]
          forSelector:NSStringFromSelector(@selector(setDividerImage:forLeftSegmentState:rightSegmentState:barMetrics:))];
}

- (void)dealloc
{
    self.notificationRegistered = NO;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:[AUUThemeManager sharedManager].changeThemeNotification object:nil];
}

@end
