//
//  UIView+AUUTheme.h
//  ThemeTest
//
//  Created by JyHu on 2017/2/14.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UIColorApperanceProtocol;

@interface UIView (AUUTheme)

@property (retain, nonatomic) UIColor *app_backgroundColor;
@property (retain, nonatomic) UIColor *app_layerBackgroundColor;

@end
