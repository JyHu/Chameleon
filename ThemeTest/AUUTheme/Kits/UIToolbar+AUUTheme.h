//
//  UIToolbar+AUUTheme.h
//  ThemeTest
//
//  Created by 胡金友 on 2017/2/23.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIToolbar (AUUTheme)

@property (retain, nonatomic, setter=setTintColorIdentifier:) NSString *tintColorIdentifier;

@property (retain, nonatomic, setter=setBarTintColorIdentifier:)NSString *barTintColorIdentifier;

@end
