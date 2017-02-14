//
//  UIImage+AUUTheme.h
//  ThemeTest
//
//  Created by JyHu on 2017/2/14.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (AUUTheme)

/**
 根据给定的标识符来找到当前主题中所对应的土坯那

 @param identifier 图片的标识符
 @return 返回找到的图片，否则返回默认的图片
 */
+ (UIImage *)imageWithIdentifier:(NSString *)identifier;

@end
