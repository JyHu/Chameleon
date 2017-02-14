//
//  UIButton+AUUTheme.h
//  ThemeTest
//
//  Created by JyHu on 2017/2/14.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (AUUTheme)

- (void)setTitleColorWithIdentifier:(NSString *)identifier forState:(UIControlState)state;

- (void)setImageWithIdentifier:(NSString *)identifier forState:(UIControlState)state;

- (void)setBackgroundImageWithIdentifier:(NSString *)identifier forState:(UIControlState)state;

@end
