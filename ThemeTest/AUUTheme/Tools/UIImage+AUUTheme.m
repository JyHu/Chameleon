//
//  UIImage+AUUTheme.m
//  ThemeTest
//
//  Created by JyHu on 2017/2/14.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "UIImage+AUUTheme.h"
#import "AUUThemeManager.h"

@implementation UIImage (AUUTheme)

+ (UIImage *)imageWithIdentifier:(NSString *)identifier
{
    NSDictionary *imageInfo = [AUUThemeManager sharedManager].themeInfos[@"images"][identifier];
    if (imageInfo) {
        NSInteger type = [imageInfo[@"type"] integerValue];
        NSString *imgId = imageInfo[@"name"];
        switch (type) {
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
