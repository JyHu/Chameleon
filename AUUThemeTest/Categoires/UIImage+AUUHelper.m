//
//  UIImage+AUUHelper.m
//  ThemeTest
//
//  Created by JyHu on 2017/2/24.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "UIImage+AUUHelper.h"

@implementation UIImage (AUUHelper)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    return [self imageWithColor:color size:CGSizeMake(1, 1)];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (instancetype)defaultImage {
    return [[UIImage imageWithColor:[UIColor redColor]] apperanceIdentifier:AUUImageDefault];
}

+ (instancetype)navbarBackgroundImage {
    return [[UIImage imageWithColor:[UIColor whiteColor]] apperanceIdentifier:AUUImageBackgroundNavbar];
}

+ (instancetype)referArrowImage {
    return [[UIImage imageWithColor:[UIColor purpleColor]] apperanceIdentifier:AUUImageRefreshArrow];
}

+ (instancetype)head1Image {
    return [[UIImage imageWithColor:[UIColor randomColor]] apperanceIdentifier:AUUImageHeadHead1];
}

+ (instancetype)head2Image {
    return [[UIImage imageWithColor:[UIColor randomColor]] apperanceIdentifier:AUUImageHeadHead2];
}

+ (instancetype)head3Image {
    return [[UIImage imageWithColor:[UIColor randomColor]] apperanceIdentifier:AUUImageHeadHead3];
}

@end
