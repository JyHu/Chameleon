//
//  UIImageView+AUUTheme.m
//  ThemeTest
//
//  Created by JyHu on 2017/2/14.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "UIImageView+AUUTheme.h"
#import "NSObject+AUUTheme.h"
#import "NSString+_AUUPrivateHelper.h"
#import "AUUThemeManager.h"

@implementation UIImageView (AUUTheme)

- (void)setImageWithIdentifier:(NSString *)imageIdentifier
{
    [self cacheParams:@[imageIdentifier.imageType] forSelector:NSStringFromSelector(@selector(setImage:))];
}

- (void)setHighlightedImageWithIdentifier:(NSString *)highlightedImageIdentifier
{
    [self cacheParams:@[highlightedImageIdentifier.imageType] forSelector:NSStringFromSelector(@selector(setHighlightedImage:))];
}

- (void)dealloc
{
    self.notificationRegistered = NO;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:[AUUThemeManager sharedManager].changeThemeNotification object:nil];
}


@end
