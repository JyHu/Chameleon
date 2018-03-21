//
//  HMSegmentedControl+AUUHelper.m
//  ThemeTest
//
//  Created by JyHu on 2017/2/26.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "HMSegmentedControl+AUUHelper.h"
#import "NSObject+AUUTheme.h"
#import <UIView_Borders/UIView+Borders.h>

@implementation HMSegmentedControl (AUUHelper)

@dynamic appearanceIdentifier;

- (void)setAppearanceIdentifier:(NSString *)appearanceIdentifier
{
    [self cacheThemeParams:@[[AUUApperanceModel apperanceIdentifier:appearanceIdentifier defaultValue:nil]] forSelector:@selector(setAppearance:)];
}

- (void)setAppearance:(NSDictionary *)appearance
{
    self.backgroundColor = [UIColor colorWithHexString:appearance[@"background"]];
    self.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithHexString:appearance[@"titlecolor"]]};
    self.selectionIndicatorColor = [UIColor colorWithHexString:appearance[@"indicatorColor"]];
    self.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithHexString:appearance[@"selectedTitleColor"]]};
    [self addBottomBorderWithHeight:(1.0 / [UIScreen mainScreen].scale) andColor:[UIColor colorWithHexString:appearance[@"bottomBorder"]]];
    [self setNeedsDisplay];
}

@end
