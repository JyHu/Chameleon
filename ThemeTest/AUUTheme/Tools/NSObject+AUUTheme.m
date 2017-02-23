//
//  NSObject+AUUTheme.m
//  ThemeTest
//
//  Created by JyHu on 2017/2/14.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "NSObject+AUUTheme.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "NSString+AUUTheme.h"
#import "UIColor+AUUTheme.h"
#import "UIImage+AUUTheme.h"
#import "AUUThemeManager.h"
#import "NSObject+AUUMethodCache.h"

void methodExchangeImplementations(Class cls, SEL originSelector, SEL swizedSelector)
{
    Method originMethod = class_getInstanceMethod(cls, originSelector);
    Method swizedMethod = class_getInstanceMethod(cls, swizedSelector);
    
    method_exchangeImplementations(swizedMethod, originMethod);
    NSLog(@"exchange  %@", NSStringFromClass(cls));
}

@implementation NSObject (AUUTheme)

void const *notificationRegisteredAssociateKey = (void *)@"notificationRegisteredAssociateKey";

- (void)setNotificationRegistered:(BOOL)notificationRegistered
{
    objc_setAssociatedObject(self, notificationRegisteredAssociateKey, @(notificationRegistered), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (BOOL)notificationRegistered
{
    id obj = objc_getAssociatedObject(self, notificationRegisteredAssociateKey);
    
    return obj ? [obj boolValue] : NO;
}

- (void)cacheParams:(NSArray *)params forSelector:(SEL)sel
{
    [self registerThemeChangeNotification];
    
    AUUArgumentTransfer transfer = ^id(id object, SEL sel, id arg, NSUInteger argIndex) {
        
        if ([arg isKindOfClass:[NSString class]])
        {
            NSString *argString = (NSString *)arg;
            
            if ([argString.themeTransferType isEqualToString:NSStringFromClass([UIColor class])])   // 如果当前参数是为了设定颜色的，则换成正常的颜色
            {
                return [UIColor colorWithIdentifier:argString];
            }
            else if ([argString.themeTransferType isEqualToString:NSStringFromClass([UIImage class])])  // 如果当前的参数是为了设定图片的，则换成正常的图片
            {
                return [UIImage imageWithIdentifier:argString];
            }
        }
        return arg;
    };
        
    [self cacheParams:params forSelector:sel argTransfer:transfer];
    
    [self performSelector:sel params:params argTransfer:transfer];
}

- (void)updateTheme
{
    [self performAllCachedSelector];
}

- (void)registerThemeChangeNotification
{
    // 只有在未设置的时候才需要来设置，避免重复设置
    
    if (!self.notificationRegistered)
    {
        self.notificationRegistered = YES;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updateTheme)
                                                     name:[AUUThemeManager sharedManager].changeThemeNotification
                                                   object:nil];
    }
}

+ (void)methodExchangeImplementationsWithOriginSelector:(SEL)originSelector swizedSelector:(SEL)swizedSelector
{
    methodExchangeImplementations([self class], originSelector, swizedSelector);
}

- (id)showNoneIdentifierTips
{
    NSLog(@"Opps, please set the identifier first");
    return nil;
}

@end
