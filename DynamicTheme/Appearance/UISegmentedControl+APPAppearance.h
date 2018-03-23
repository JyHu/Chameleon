//
//  UISegmentedControl+APPAppearance.h
//  DynamicTheme
//
//  Created by 胡金友 on 2018/3/23.
//

#import <UIKit/UIKit.h>

@interface UISegmentedControl (APPAppearance)

@property (nonatomic, strong) UIColor *app_tintColor;

- (void)setApp_Image:(UIImage *)image forSegmentAtIndex:(NSUInteger)segment;

- (void)setApp_BackgroundImage:(UIImage *)backgroundImage
                      forState:(UIControlState)state barMetrics:(UIBarMetrics)barMetrics;

- (void)setApp_DividerImage:(UIImage *)dividerImage
        forLeftSegmentState:(UIControlState)leftState
          rightSegmentState:(UIControlState)rightState
                 barMetrics:(UIBarMetrics)barMetrics;

@end
