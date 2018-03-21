//
//  NSObject+AUUTheme.h
//  ThemeTest
//
//  Created by JyHu on 2017/2/14.
//  Copyright © 2017年 JyHu. All rights reserved.
//




#import <Foundation/Foundation.h>
#import "NSString+AUUTheme.h"
#import "UIColor+AUUTheme.h"
#import "UIImage+AUUTheme.h"
#import "AUUThemeManager.h"

@interface NSObject (AUUTheme)

- (void)cacheThemeParams:(NSArray *)params forSelector:(SEL)sel;

@end


