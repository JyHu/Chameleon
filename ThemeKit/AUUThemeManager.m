//
//  AUUThemeManager.m
//  ThemeTest
//
//  Created by JyHu on 2017/2/13.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "AUUThemeManager.h"
#import "UIColor+AUUTheme.h"
#import "UIImage+AUUTheme.h"

NSString *const ThemeApperanceChangeNotification = @"com.jyhu.ThemeApperanceChangeNotification";

@interface AUUThemeManager()

@property (retain, nonatomic) NSDictionary *pri_themeInfo;

@property (retain, nonatomic) NSString *pri_currentThemeSourcePath;

@end

@implementation AUUThemeManager

+ (instancetype)sharedManager
{
    static AUUThemeManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AUUThemeManager alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    if ((self = [super init]))
    {
        self.defaultColor = [UIColor redColor];
        self.defaultImage = [UIImage new];
    }
    
    return self;
}

- (BOOL)changeThemeWithSourcePath:(NSString *)sourcePath themeInfo:(NSDictionary *)themeInfo
{
// MARK: 添加对themeInfo的判断
    self.pri_currentThemeSourcePath = sourcePath;
    self.pri_themeInfo = themeInfo;
    [[NSNotificationCenter defaultCenter] postNotificationName:ThemeApperanceChangeNotification object:nil];
    
    return YES;
}

#pragma mark - getter

- (NSDictionary *)themeInfos
{
    return self.pri_themeInfo;
}

- (NSString *)currentThemeSourcePath
{
    return self.pri_currentThemeSourcePath;
}

- (UIImage *)defaultImage
{
    if (!_defaultImage)
    {
        return [UIImage imageWithColor:[UIColor randomColor]];
    }
    
    return _defaultImage;
}

- (UIColor *)defaultColor
{
    if (!_defaultColor)
    {
        return [UIColor randomColor];
    }
    
    return _defaultColor;
}

@end
