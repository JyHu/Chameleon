//
//  NSString+APPAppearance.h
//  DynamicTheme
//
//  Created by 胡金友 on 2018/3/23.
//

#import <Foundation/Foundation.h>

@interface NSString (APPAppearance)

/**
 返回上一级的标识符，用于在读取主题文件时的解析
 
 @return 标识符
 */
- (NSString *)superIdentifier;

@end
