//
//  UINavigationBar+AUUTheme.h
//  ThemeTest
//
//  Created by JyHu on 2017/2/25.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UIColorApperanceProtocol;
@protocol UIImageApperanceProtocol;

@interface UINavigationBar (AUUTheme)

@property (nonatomic, strong) UIColor *app_titleColor;

- (void)setApp_BackgroundImage:(UIImage *)image forBarMetrics:(UIBarMetrics)barMetrics;

@end
