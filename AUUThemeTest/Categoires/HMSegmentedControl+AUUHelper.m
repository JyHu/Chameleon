//
//  HMSegmentedControl+AUUHelper.m
//  ThemeTest
//
//  Created by JyHu on 2017/2/26.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "HMSegmentedControl+AUUHelper.h"
#import "NSObject+APPAppearance.h"
#import <UIView_Borders/UIView+Borders.h>

@implementation HMSegmentedControl (AUUHelper)

@dynamic appearanceIdentifier;

- (void)setAppearanceIdentifier:(NSString *)appearanceIdentifier
{
    [self cacheThemeParams:@[[APPCustomAppearanceModel apperanceWithIdentifier:appearanceIdentifier]] forSelector:@selector(setAppearance:)];
}

- (void)setAppearance:(NSDictionary *)appearance {
    if (appearance) {
        self.backgroundColor = [UIColor app_colorWithHexString:appearance[@"background"]];
        self.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor app_colorWithHexString:appearance[@"titlecolor"]]};
        self.selectionIndicatorColor = [UIColor app_colorWithHexString:appearance[@"indicatorColor"]];
        self.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor app_colorWithHexString:appearance[@"selectedTitleColor"]]};
        [self addBottomBorderWithHeight:(1.0 / [UIScreen mainScreen].scale) andColor:[UIColor app_colorWithHexString:appearance[@"bottomBorder"]]];
        [self setNeedsDisplay];
    }
}

@end
