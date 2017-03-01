//
//  UISwitch+AUUTheme.h
//  ThemeTest
//
//  Created by JyHu on 2017/2/14.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISwitch (AUUTheme)

@property (retain, nonatomic, setter=setTintColorIdentifier:) NSString *tintColorIdentifier;

@property (retain, nonatomic, setter=setOnTintColorIdentifier:) NSString *onTintColorIdentifier;

@property (retain, nonatomic, setter=setThumbTintColorIdentifier:) NSString *thumbTintColorIdentifier;

@property (retain, nonatomic, setter=setOnImageIdentifier:) NSString *onImageIdentifier;

@property (retain, nonatomic, setter=setOffImageIdentifier:) NSString *offImageIdentifier;

@end
