//
//  NSObject+AUUTheme.h
//  ThemeTest
//
//  Created by JyHu on 2017/2/14.
//  Copyright © 2017年 JyHu. All rights reserved.
//










// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




//   You'd better import this file only in the .m files of your categories





// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
// %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%












#import <Foundation/Foundation.h>
#import "NSObject+AUUMethodCache.h"
#import "NSString+AUUTheme.h"
#import "UIColor+AUUTheme.h"
#import "UIImage+AUUTheme.h"
#import "AUUThemeManager.h"

#define AUUNoneIdentifierTips [self showNoneIdentifierTips]

@interface NSObject (AUUTheme)

/**
 method swizzing

 @param originSelector original selector
 @param swizedSelector swized selector
 */
+ (void)methodExchangeImplementationsWithOriginSelector:(SEL)originSelector swizedSelector:(SEL)swizedSelector;

/**
 记录当前对象是否设置了通知
 */
@property (assign, nonatomic) BOOL notificationRegistered;

/**
 更换主题颜色、图片
 */
- (void)updateTheme;

/**
 注册主题改动的通知，所有的UIKit类有颜色、图片改动的都需要设定
 */
- (void)registerThemeChangeNotification;

/**
 用于显示没有设置identifier却去读取的log提示

 @return nil
 */
- (id)showNoneIdentifierTips;

@end


