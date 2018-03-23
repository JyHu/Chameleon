//
//  UIImage+AUUHelper.m
//  ThemeTest
//
//  Created by JyHu on 2017/2/24.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "UIImage+AUUHelper.h"

@implementation UIImage (AUUHelper)

+ (instancetype)defaultImage {
    return [[UIImage app_imageWithColor:[UIColor redColor]] appearanceIdentifier:AUUImageDefault];
}

+ (instancetype)navbarBackgroundImage {
    return [[UIImage app_imageWithColor:[UIColor whiteColor]] appearanceIdentifier:AUUImageBackgroundNavbar];
}

+ (instancetype)referArrowImage {
    return [[UIImage app_imageWithColor:[UIColor purpleColor]] appearanceIdentifier:AUUImageRefreshArrow];
}

+ (instancetype)head1Image {
    return [[UIImage app_imageWithColor:[UIColor app_randomColor]] appearanceIdentifier:AUUImageHeadHead1];
}

+ (instancetype)head2Image {
    return [[UIImage app_imageWithColor:[UIColor app_randomColor]] appearanceIdentifier:AUUImageHeadHead2];
}

+ (instancetype)head3Image {
    return [[UIImage app_imageWithColor:[UIColor app_randomColor]] appearanceIdentifier:AUUImageHeadHead3];
}

@end
