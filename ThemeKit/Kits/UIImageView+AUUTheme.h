//
//  UIImageView+AUUTheme.h
//  ThemeTest
//
//  Created by JyHu on 2017/2/14.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UIImageApperanceProtocol;

@interface UIImageView (AUUTheme)

@property (nonatomic, strong) UIImage *app_image;
@property (nonatomic, strong) UIImage *app_highlightedImage;

@end
