//
//  UIButton+AUUTheme.h
//  ThemeTest
//
//  Created by JyHu on 2017/2/14.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (AUUTheme)

- (void)setApp_TitleColor:(UIColor *)color forState:(UIControlState)state;
- (void)setApp_Image:(UIImage *)image forState:(UIControlState)state;
- (void)setApp_BackgroundImage:(UIImage *)image forState:(UIControlState)state;

@end
