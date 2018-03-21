//
//  NSObject+AUUTheme.h
//  ThemeTest
//
//  Created by JyHu on 2017/2/14.
//  Copyright © 2017年 JyHu. All rights reserved.
//




#import <Foundation/Foundation.h>

/**
 用于在调用方法的时候返回正确的参数类型
 
 @param object 当前的对象
 @param sel 方法名
 @param params 参数列表
 @param argIndex 当前参数的索引，也就是第几个，默认从第0个开始，需要注意的是，这里的位置索引不是runtime中参数的位置索引
 @return 正确的参数，如果是基本数据类型，可以转成对应的对象，比如 int、float、CGFloat、NSInteger、等可以转成 NSNumber
 */
typedef id (^AUUArgumentTransfer)(id object, SEL sel, NSArray *params, NSUInteger argIndex, BOOL *skip);

@interface NSObject (AUUTheme)

- (void)cacheThemeParams:(NSArray *)params forSelector:(SEL)sel argumentTransfer:(AUUArgumentTransfer)transfer;
- (void)cacheThemeParams:(NSArray *)params forSelector:(SEL)sel;

- (NSString *)hashKeyForParams:(NSArray *)params;

- (id)cachedParamForSelector:(SEL)selector;

@end


