//
//  UISwitch+AUUTheme.h
//  ThemeTest
//
//  Created by JyHu on 2017/2/14.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISwitch (AUUTheme)

- (void)setTintColorWithIdentifier:(NSString *)tintColorIdentifier;

- (void)setOnTintColorWithIdentifier:(NSString *)onTintColorIdentifier;

- (void)setThumbTintColorWithIdentifier:(NSString *)thumbTintColorIdentifier;

- (void)setOnImageWithIdentifier:(NSString *)onImageIdentifier;

- (void)setOffImageWithIdentifier:(NSString *)offImageIdentifier;

@end
