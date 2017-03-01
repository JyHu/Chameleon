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

+ (UIImage *)imageWithIdentifier:(NSString *)identifier imageURLPath:(NSString *__autoreleasing *)urlPath
{
    if (!identifier)
    {
        return [AUUThemeManager sharedManager].defaultImage;
    }
    
    NSDictionary *images = [AUUThemeManager sharedManager].themeInfos[@"images"];
    
    if (images)
    {
        NSDictionary *imageInfo = images[identifier];
        
        if (!imageInfo)
        {
            return [UIImage imageWithIdentifier:[identifier superIdentifier] imageURLPath:urlPath];
        }
        else
        {
            return [UIImage imageWithImageInfo:imageInfo imageURLPath:urlPath];
        }
    }
    
    return [AUUThemeManager sharedManager].defaultImage;
}

+ (UIImage *)imageWithImageInfo:(NSDictionary *)imageInfo imageURLPath:(NSString *__autoreleasing *)urlPath
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
            {   // 在这里因为是网络图片，所以需要将网络图片的地址传回去
                *urlPath = imageInfo[@"path"];
                return nil;
            }
                
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
