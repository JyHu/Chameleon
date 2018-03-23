//
//  UINavigationBar+APPAppearance.h
//  DynamicTheme
//
//  Created by 胡金友 on 2018/3/23.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (APPAppearance)

@property (nonatomic, strong) UIColor *app_titleColor;

- (void)setApp_BackgroundImage:(UIImage *)image forBarMetrics:(UIBarMetrics)barMetrics;

@end
