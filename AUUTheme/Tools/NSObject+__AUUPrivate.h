//
//  NSObject+__AUUPrivate.h
//  ThemeTest
//
//  Created by JyHu on 2017/2/24.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (__AUUPrivate)

/**
 用于在字典中缓存当前的对象
 */
@property (weak, nonatomic) id performTarget;

/**
 设置字典中缓存的当前对象

 @param target 当前对象
 @return self
 */
- (id)setPerformerWithTarget:(id)target;

/**
 根据参数的hashCode执行一个方法

 @param sel 方法名
 @param params 参数列表
 @param hashCode 参数列表的hashCode
 */
- (void)performSelector:(SEL)sel params:(NSArray *)params hashCode:(NSString *)hashCode;

/**
 获取一个参数列表的hashCode

 @param params 参数列表
 @return hashCode
 */
- (NSString *)hashKeyForParams:(NSArray *)params;

@end
