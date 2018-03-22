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

@property (nonatomic, strong) NSDictionary *cachedThemeInfoDict;
@property (nonatomic, copy) NSString *cachedThemeSourcePath;

@property (nonatomic, strong, readwrite) UIColor *defaultColor;
@property (nonatomic, strong, readwrite) UIImage *defaultImage;

@end

@implementation AUUThemeManager

+ (instancetype)sharedManager {
    static AUUThemeManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AUUThemeManager alloc] init];
    });
    return manager;
}

- (instancetype)init {
    if ((self = [super init])) {
        self.defaultColor = [UIColor randomColor];
        self.defaultImage = [UIImage new];
    }
    
    return self;
}

- (BOOL)changeThemeWithSourcePath:(NSString *)sourcePath themeInfo:(NSDictionary *)themeInfo {
// MARK: 添加对themeInfo的判断
    self.cachedThemeSourcePath = sourcePath;
    self.cachedThemeInfoDict = themeInfo;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ThemeApperanceChangeNotification object:nil];
    
    return YES;
}

- (void)registerDefaultColor:(UIColor *)color {
    self.defaultColor = color;
}

- (void)registerDefaultImage:(UIImage *)image {
    self.defaultImage = image;
}

- (NSDictionary *)colorsInfo {
    return self.themeDelegate ? self.themeDelegate.colorsInfo : self.cachedThemeInfoDict[@"colors"];
}

- (NSDictionary *)imagesInfo {
    return self.themeDelegate ? self.themeDelegate.imagesInfo : self.cachedThemeInfoDict[@"images"];
}

- (NSDictionary *)apperancesInfo {
    return self.themeDelegate ? self.themeDelegate.apperancesInfo : self.cachedThemeInfoDict[@"appearance"];
}

- (NSString *)currentThemePath {
    return self.themeDelegate ? self.themeDelegate.currentThemePath : _cachedThemeSourcePath;
}

- (UIImage *)defaultImage {
    return self.themeDelegate ? self.themeDelegate.defaultImage : _defaultImage;
}

- (UIColor *)defaultColor {
    return self.themeDelegate ? self.themeDelegate.defaultColor : _defaultColor;
}

@end
