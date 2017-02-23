//
//  UISegmentedControl+AUUTheme.m
//  ThemeTest
//
//  Created by JyHu on 2017/2/14.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "UISegmentedControl+AUUTheme.h"
#import "NSObject+AUUTheme.h"
#import "NSString+AUUTheme.h"
#import "AUUThemeManager.h"

@implementation UISegmentedControl (AUUTheme)

- (void)setTintColorIdentifier:(NSString *)tintColorIdentifier
{
    [self cacheParams:@[tintColorIdentifier.colorType] forSelector:@selector(setTintColor:)];
}

- (NSString *)tintColorIdentifier
{
    return [[[self cachedParamsForSelector:@selector(setTintColor:)] firstObject] firstObject] ?: AUUNoneIdentifierTips;
}

- (void)setImageWithIdentifier:(NSString *)imageIdentifier forSegmentAtIndex:(NSUInteger)segment
{
    [self cacheParams:@[imageIdentifier.imageType, @(segment)]
          forSelector:@selector(setImage:forSegmentAtIndex:)];
}

- (NSArray *)imageIdentifiersForSegments
{
    return [self cachedParamsForSelector:@selector(setImage:forSegmentAtIndex:)] ?: AUUNoneIdentifierTips;
}

- (void)setBackgroundImageWithIdentifier:(NSString *)backgroundImageIdentifier
                                forState:(UIControlState)state barMetrics:(UIBarMetrics)barMetrics
{
    [self cacheParams:@[backgroundImageIdentifier.imageType, @(state), @(barMetrics)]
          forSelector:@selector(setBackgroundImage:forState:barMetrics:)];
}

- (NSArray *)backgroundImageIdentifiers
{
    return [self cachedParamsForSelector:@selector(setBackgroundImage:forState:barMetrics:)] ?: AUUNoneIdentifierTips;
}

- (void)setDividerImageWithIdentifier:(NSString *)dividerImageIdentifier forLeftSegmentState:(UIControlState)leftState
                    rightSegmentState:(UIControlState)rightState barMetrics:(UIBarMetrics)barMetrics
{
    [self cacheParams:@[dividerImageIdentifier.imageType, @(leftState), @(rightState), @(barMetrics)]
          forSelector:@selector(setDividerImage:forLeftSegmentState:rightSegmentState:barMetrics:)];
}

- (NSArray *)dividerImageIdentifies
{
    return [self cachedParamsForSelector:@selector(setDividerImage:forLeftSegmentState:rightSegmentState:barMetrics:)];
}

- (void)dealloc
{
    self.notificationRegistered = NO;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:[AUUThemeManager sharedManager].changeThemeNotification object:nil];
}

@end
