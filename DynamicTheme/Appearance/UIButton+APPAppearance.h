//
//  UIButton+APPAppearance.h
//  DynamicTheme
//
//  Created by 胡金友 on 2018/3/23.
//

#import <UIKit/UIKit.h>

@interface UIButton (APPAppearance)

- (void)setApp_TitleColor:(UIColor *)color forState:(UIControlState)state;
- (void)setApp_Image:(UIImage *)image forState:(UIControlState)state;
- (void)setApp_BackgroundImage:(UIImage *)image forState:(UIControlState)state;

@end
