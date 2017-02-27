//
//  NSDictionary+AUUMethodCache.m
//  ThemeTest
//
//  Created by JyHu on 2017/2/24.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "NSDictionary+AUUMethodCache.h"
#import "NSObject+__AUUPrivate.h"
#import "NSObject+AUUMethodCache.h"

@implementation NSDictionary (AUUMethodCache)

- (void)execute
{
    [self.performTarget performSelector:NSSelectorFromString([[self allKeys] firstObject]) params:[[self allValues] firstObject]];
}

@end
