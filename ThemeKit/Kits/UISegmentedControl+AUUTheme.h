//
//  UISegmentedControl+AUUTheme.h
//  ThemeTest
//
//  Created by JyHu on 2017/2/14.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UISegmentedControl (AUUTheme)

@property (nonatomic, strong) UIColor *app_tintColor;

- (void)setApp_Image:(UIImage *)image forSegmentAtIndex:(NSUInteger)segment;

- (void)setApp_BackgroundImage:(UIImage *)backgroundImage
                      forState:(UIControlState)state barMetrics:(UIBarMetrics)barMetrics;

- (void)setApp_DividerImage:(UIImage *)dividerImage
        forLeftSegmentState:(UIControlState)leftState
          rightSegmentState:(UIControlState)rightState
                 barMetrics:(UIBarMetrics)barMetrics;

@end
