//
//  NSString+AUUTheme.h
//  ThemeTest
//
//  Created by 胡金友 on 2017/2/22.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AUUTheme)

/**
 用于缓存当前这个identifier字符串所对应的对象类型
 */
@property (retain, nonatomic) NSString *themeTransferType;

/**
 只读，返回值还是自身，用于设定当前identifier字符串所对应的对象类型为颜色
 */
@property (retain, nonatomic, readonly) NSString *colorType;

/**
 只读，返回值还是自身，用于设定当前identifier字符串所对应的对象类型为图片
 */
@property (retain, nonatomic, readonly) NSString *imageType;

/**
 根据给定的正则来获取字符串中所对应的有效部分
 
 @param pattern 正则表达式
 @return 正则匹配出的结果
 */
- (NSString *)matchResultWithPattern:(NSString *)pattern;

/**
 返回上一级的标识符，用于在读取主题文件时的解析
 
 @return 标识符
 */
- (NSString *)superIdentifier;

@end
