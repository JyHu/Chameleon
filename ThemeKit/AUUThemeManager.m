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

@interface AUUThemeManager()

@property (retain, nonatomic) NSString *pri_changeThemeNotification;

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

- (void)registerThemeChangeNotification:(NSString *)notificationName
{
    NSAssert(notificationName && [notificationName isKindOfClass:[NSString class]] &&
             [notificationName stringByReplacingOccurrencesOfString:@" " withString:@""].length > 0,
             @"无效的主题更换通知");
    self.pri_changeThemeNotification = notificationName;
}

- (BOOL)changeThemeWithSourcePath:(NSString *)sourcePath themeInfo:(NSDictionary *)themeInfo
{
// MARK: 添加对themeInfo的判断
    self.pri_currentThemeSourcePath = sourcePath;
    self.pri_themeInfo = themeInfo;
    [[NSNotificationCenter defaultCenter] postNotificationName:self.pri_changeThemeNotification object:nil];
    
    return YES;
}

#pragma mark - getter

- (NSString *)changeThemeNotification
{
    if (self.pri_changeThemeNotification)
    {
        return self.pri_changeThemeNotification;
    }
    
    return @"com.jyhu.notification.changeTheme";
}

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
