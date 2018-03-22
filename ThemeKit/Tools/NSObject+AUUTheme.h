//
//  NSObject+AUUTheme.h
//  ThemeTest
//
//  Created by JyHu on 2017/2/14.
//  Copyright © 2017年 JyHu. All rights reserved.
//




#import <Foundation/Foundation.h>


@interface NSObject (AUUTheme)

- (void)cacheThemeParams:(NSArray *)params forSelector:(SEL)sel manualInvokeSelector:(SEL)invokeSelector;
- (void)cacheThemeParams:(NSArray *)params forSelector:(SEL)sel;

- (id)cachedParamForSelector:(SEL)selector;

@end


