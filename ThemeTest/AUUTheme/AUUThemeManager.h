//
//  AUUThemeManager.h
//  ThemeTest
//
//  Created by JyHu on 2017/2/13.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AUUSingleton.h"
#import <UIKit/UIKit.h>

@class AUUThemeModel;

@interface AUUThemeManager : NSObject

// 通过宏的方式设置单例

singleton_h(Manager)

/**
 通过给定的标识来切换主题

 @param themeIdentifier 主题的标识
 */
- (void)changeThemeWithIdentifier:(NSString *)themeIdentifier;

/**
 主题切换的通知
 */
@property (retain, nonatomic, readonly) NSString *changeThemeNotification;

/**
 当前主题的标识
 */
@property (retain, nonatomic, readonly) NSString *currentThemeIdentifier;

/**
 当前主题的资源地址
 */
@property (retain, nonatomic, readonly) NSString *currentThemeSourcePath;

/**
 根据给定的标识来获取主题的信息

 @param identifier 主题的标识
 @return 主题model
 */
- (AUUThemeModel *)getThemeWithIdentifier:(NSString *)identifier;

/**
 当前所有的主题列表
 */
@property (retain, nonatomic) NSMutableArray *themeList;

/**
 主题信息
 */
@property (retain, nonatomic) NSDictionary *themeInfos;

/**
 默认的颜色
 */
@property (retain, nonatomic) UIColor *defaultColor;

/**
 默认的图片
 */
@property (retain, nonatomic) UIImage *defaultImage;

@end
