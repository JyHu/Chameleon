//
//  NSObject+AUUTheme.h
//  ThemeTest
//
//  Created by JyHu on 2017/2/14.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (AUUTheme)

/**
 缓存一下当前组件所有设置图片、颜色的方法及参数
 */
@property (retain, nonatomic) NSMutableDictionary *themeProperties;

/**
 记录当前对象是否设置了通知
 */
@property (assign, nonatomic) BOOL notificationRegistered;

/**
 使用NSInvocation，根据给定的方法名、参数来执行

 @param selName 方法名
 @param params 参数列表
 */
- (void)performSelectorWithName:(NSString *)selName params:(NSArray *)params;

/**
 缓存当前的设定方法

 @param params 方法的参数
 @param selName 方法名
 */
- (void)cacheParams:(NSArray *)params forSelector:(NSString *)selName;

/**
 更换主题颜色、图片
 */
- (void)updateTheme;

/**
 注册主题改动的通知，所有的UIKit类有颜色、图片改动的都需要设定
 */
- (void)registerThemeChangeNotification;

@end
