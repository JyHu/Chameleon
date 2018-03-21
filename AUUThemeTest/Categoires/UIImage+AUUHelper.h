//
//  UIImage+AUUHelper.h
//  ThemeTest
//
//  Created by JyHu on 2017/2/24.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIImage (AUUHelper)

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (instancetype)defaultImage;
+ (instancetype)navbarBackgroundImage;
+ (instancetype)referArrowImage;
+ (instancetype)head1Image;
+ (instancetype)head2Image;
+ (instancetype)head3Image;

@end
