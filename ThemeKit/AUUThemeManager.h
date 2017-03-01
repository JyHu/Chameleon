//
//  AUUThemeManager.h
//  ThemeTest
//
//  Created by JyHu on 2017/2/13.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class AUUThemeModel;

@interface AUUThemeManager : NSObject

/**
 单例

 @return self
 */
+ (instancetype)sharedManager;




#pragma mark - theme handle methods

/**
 更换主题

 @param sourcePath 主题资源的目录
 @param themeInfo 主题的详细信息
 */
- (BOOL)changeThemeWithSourcePath:(NSString *)sourcePath themeInfo:(NSDictionary *)themeInfo;

/**
 注册一个通知，用于监听主题改变

 @param notificationName 通知
 */
- (void)registerThemeChangeNotification:(NSString *)notificationName;



#pragma mark - cached the readonly properties

/**
 主题切换的通知
 */
@property (retain, nonatomic, readonly) NSString *changeThemeNotification;

/**
 主题信息
 */
@property (retain, nonatomic, readonly) NSDictionary *themeInfos;

/**
 当前主题的资源地址
 */
@property (retain, nonatomic, readonly) NSString *currentThemeSourcePath;




#pragma mark - Default setting properties

/**
 默认的颜色
 */
@property (retain, nonatomic) UIColor *defaultColor;

/**
 默认的图片
 */
@property (retain, nonatomic) UIImage *defaultImage;

@end
