//
//  NSObject+AUUMethodCache.h
//  ThemeTest
//
//  Created by 胡金友 on 2017/2/21.
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

@interface NSObject (AUUMethodCache)

#pragma mark - cache methods

/**
 缓存当前对象的某个方法和参数列表

 @param params 参数列表
 @param sel 方法名
 @param transfer Transfer
 */
- (void)cacheParams:(NSArray *)params forSelector:(SEL)sel argTransfer:(AUUArgumentTransfer)transfer;
- (void)cacheParams:(NSArray *)params forSelector:(SEL)sel;

#pragma mark - perform selector methods


/**
 使用NSInvocation的方式来调用方法

 @param sel 方法名
 @param params 方法的参数列表
 @param transfer Transfer
 */
- (void)performSelector:(SEL)sel params:(NSArray *)params argTransfer:(AUUArgumentTransfer)transfer;
- (void)performSelector:(SEL)sel params:(NSArray *)params hashCode:(NSString *)hashCode;
- (void)performSelector:(SEL)sel params:(NSArray *)params;


/**
 重新设置所有缓存的属性

 @param transfer Transfer
 */
- (void)performAllCachedSelectorWithArgumentTransfer:(AUUArgumentTransfer)transfer;
- (void)performAllCachedSelector;

/**
 获取一个参数列表的hashCode
 
 @param params 参数列表
 @return hashCode
 */
- (NSString *)hashKeyForParams:(NSArray *)params;

@end
