//
//  NSObject+__AUUPrivate.m
//  ThemeTest
//
//  Created by JyHu on 2017/2/24.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "NSObject+__AUUPrivate.h"
#import "NSObject+AUUMethodCache.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"

@implementation NSObject (__AUUPrivate)

- (void)setPerformTarget:(id)performTarget
{
    self.cachedProperties = performTarget;
}

- (id)performTarget
{
    return self.cachedProperties;
}

- (id)setPerformerWithTarget:(id)target
{
    self.performTarget = target;
    return self;
}

- (NSString *)hashKeyForParams:(NSArray *)params
{
    NSUInteger hashValue = 0;
    
    for (id param in params)
    {
        hashValue += [param hash];
    }
    
    return [NSString stringWithFormat:@"%@", @(hashValue)];
}

@end

#pragma clang diagnostic pop
