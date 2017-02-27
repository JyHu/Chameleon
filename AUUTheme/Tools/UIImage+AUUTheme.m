//
//  UIImage+AUUTheme.m
//  ThemeTest
//
//  Created by JyHu on 2017/2/14.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "UIImage+AUUTheme.h"
#import "AUUThemeManager.h"
#import "NSString+AUUTheme.h"
#import "UIColor+AUUTheme.h"

@implementation UIImage (AUUTheme)

+ (UIImage *)imageWithIdentifier:(NSString *)identifier
{
    if (!identifier) {
        return [AUUThemeManager sharedManager].defaultImage;
    }
    
    NSDictionary *images = [AUUThemeManager sharedManager].themeInfos[@"images"];
    
    if (images)
    {
        NSDictionary *imageInfo = images[identifier];
        
        if (!imageInfo)
        {
            return [UIImage imageWithIdentifier:[identifier superIdentifier]];
        }
        else
        {
            return [UIImage imageWithImageInfo:imageInfo];
        }
    }
    
    return [AUUThemeManager sharedManager].defaultImage;
}

+ (UIImage *)imageWithImageInfo:(NSDictionary *)imageInfo
{
    if (imageInfo)
    {
        NSInteger type = [imageInfo[@"type"] integerValue];
        
        switch (type)
        {
            case 0:
                return [UIImage imageNamed:imageInfo[@"name"]];
                
            case 1:
                return [UIImage imageWithContentsOfFile:[[AUUThemeManager sharedManager].currentThemeSourcePath stringByAppendingPathComponent:imageInfo[@"name"]]];
            
            case 2:
                return [UIImage imageWithColor:[UIColor colorWithHexString:imageInfo[@"color"]]];
                
            case 3:
                return (UIImage *)imageInfo[@"path"];
                
            default:
                break;
        }
    }
    
    return [AUUThemeManager sharedManager].defaultImage;
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
