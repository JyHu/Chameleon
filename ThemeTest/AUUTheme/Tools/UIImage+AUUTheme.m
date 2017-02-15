//
//  UIImage+AUUTheme.m
//  ThemeTest
//
//  Created by JyHu on 2017/2/14.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "UIImage+AUUTheme.h"
#import "AUUThemeManager.h"
#import "NSString+_AUUPrivateHelper.h"

@implementation UIImage (AUUTheme)

+ (UIImage *)imageWithIdentifier:(NSString *)identifier
{
    NSDictionary *images = [AUUThemeManager sharedManager].themeInfos[@"images"];
    
    if (images)
    {
        NSDictionary *imageInfo = images[identifier];
        
        if (!(imageInfo && imageInfo[@"name"]))
        {
            NSString *superIdentfier = [identifier superIdentifier];
          
            if (superIdentfier)
            {
                return [UIImage imageWithIdentifier:superIdentfier];
            }
            else
            {
                NSDictionary *defaultImageInfo = images[@"__default__"];
                
                if (defaultImageInfo && defaultImageInfo[@"name"])
                {
                    return [UIImage imageWithImageInfo:defaultImageInfo];
                }
            }
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
        
        NSString *imgId = imageInfo[@"name"];
        
        switch (type)
        {
            case 1:
                return [UIImage imageNamed:imgId];
                
            case 0:
                return [UIImage imageWithContentsOfFile:[[AUUThemeManager sharedManager].currentThemeSourcePath stringByAppendingPathComponent:imgId]];
                
            default:
                break;
        }
    }
    
    return [AUUThemeManager sharedManager].defaultImage;
}

@end
