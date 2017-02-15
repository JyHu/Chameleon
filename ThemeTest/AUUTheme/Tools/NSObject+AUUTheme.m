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
#import "NSString+_AUUPrivateHelper.h"
#import "UIColor+AUUTheme.h"
#import "UIImage+AUUTheme.h"
#import "AUUThemeManager.h"

@implementation NSObject (AUUTheme)

void const *themePropertiesAssociateKey = (void *)@"themePropertiesAssociateKey";

- (void)setThemeProperties:(NSMutableDictionary *)themeProperties
{
    objc_setAssociatedObject(self, themePropertiesAssociateKey, themeProperties, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)themeProperties
{
    NSMutableDictionary *properties = objc_getAssociatedObject(self, themePropertiesAssociateKey);
    
    if (!properties)
    {
        properties = [[NSMutableDictionary alloc] init];
        
        [self setThemeProperties:properties];
    }
    
    return properties;
}

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

- (void)performSelectorWithName:(NSString *)selName params:(NSArray *)params
{
    // https://opensource.apple.com/source/objc4/objc4-706/runtime/runtime.h.auto.html
    
    SEL                 sel             = NSSelectorFromString(selName);
    Method              method          = class_getInstanceMethod([self class], sel);
    NSMethodSignature   *signature      = [[self class] instanceMethodSignatureForSelector:sel];
    NSInvocation        *invocation     = [NSInvocation invocationWithMethodSignature:signature];
    NSMutableArray      *tempArguments  = [[NSMutableArray alloc] init];  // 暂存一些对象，避免zombie
    
    invocation.selector = sel;
    
    for (unsigned int i = 0; i < params.count; i ++)
    {
        char type[256]; // 方法参数的类型
        
        /*
         用于获取方法的参数类型
         方法原型：
            void method_getArgumentType(Method m, unsigned int index, char *dst, size_t dst_len)
        index 从i+2开始是因为:
            在运行时方法的执行都是走的objc_msgSend(Class cls, SEL sel, ....)，前两个参数都是固定的表示类本身和方法名，所以参数是从第三个（即index = 2）开始。
            在下面设定参数的时候也是必须要从index=2开始
            http://www.auu.space/2016/04/30/iOS方法调用之NSInvocation/
         
         */
        method_getArgumentType(method, i + 2, type, 256);
        
        id currentArgument = params[i];
        
        // 顾虑掉无效的空白部分
        NSString *octype = [[NSString stringWithUTF8String:type] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
        
        if ([octype isEqualToString:@"#"])          // Class
        {
            Class argumentCls = NSClassFromString(currentArgument);
            [invocation setArgument:&argumentCls atIndex:2 + i];
        }
        else if ([octype isEqualToString:@":"])     // Selector
        {
            SEL argumentSEL = NSSelectorFromString(currentArgument);
            [invocation setArgument:&argumentSEL atIndex:2 + i];
        }
        else if ([octype isEqualToString:@"c"])     // Char
        {
            char argumentC = [currentArgument charValue];
            [invocation setArgument:&argumentC atIndex:2 + i];
        }
        else if ([octype isEqualToString:@"C"])
        {
            unsigned char argumentUC = [currentArgument unsignedCharValue];
            [invocation setArgument:&argumentUC atIndex:2 + i];
        }
        else if ([octype isEqualToString:@"s"])
        {
            short argumentS = [currentArgument shortValue];
            [invocation setArgument:&argumentS atIndex:2 + i];
        }
        else if ([octype isEqualToString:@"S"])
        {
            unsigned short argumentUS = [currentArgument unsignedShortValue];
            [invocation setArgument:&argumentUS atIndex:2 + i];
        }
        else if ([octype isEqualToString:@"i"])
        {
            int argumentI = [currentArgument intValue];
            [invocation setArgument:&argumentI atIndex:2 + i];
        }
        else if ([octype isEqualToString:@"I"])
        {
            NSUInteger argumentUI = [currentArgument unsignedIntegerValue];
            [invocation setArgument:&argumentUI atIndex:2 + i];
        }
        else if ([octype isEqualToString:@"l"])
        {
            long argumentL = [currentArgument longValue];
            [invocation setArgument:&argumentL atIndex:2 + i];
        }
        else if ([octype isEqualToString:@"L"])
        {
            unsigned long argumentUL = [currentArgument unsignedLongValue];
            [invocation setArgument:&argumentUL atIndex:2 + i];
        }
        else if ([octype isEqualToString:@"q"])
        {
            long long argumentLL = [currentArgument longLongValue];
            [invocation setArgument:&argumentLL atIndex:2 + i];
        }
        else if ([octype isEqualToString:@"Q"])
        {
            unsigned long long argumentULL = [currentArgument unsignedLongLongValue];
            [invocation setArgument:&argumentULL atIndex:2 + i];
        }
        else if ([octype isEqualToString:@"f"])
        {
            float argumentF = [currentArgument floatValue];
            [invocation setArgument:&argumentF atIndex:2 + i];
        }
        else if ([octype isEqualToString:@"d"])
        {
            double argumentD = [currentArgument doubleValue];
            [invocation setArgument:&argumentD atIndex:2 + i];
        }
        else if ([octype isEqualToString:@"b"] || [octype isEqualToString:@"B"])
        {
            BOOL argumentB = [currentArgument boolValue];
            [invocation setArgument:&argumentB atIndex:2 + i];
        }
        else if (octype && octype.length > 0)   // 是对象或其他数据类型
        {
            if ([currentArgument isKindOfClass:[NSString class]])   // 如果当前参数是一个字符串的话，那么需要判断一下是不是图片或者、颜色的identifier
            {
                NSString *argString = (NSString *)currentArgument;
                
                if ([argString.themeTransferType isEqualToString:NSStringFromClass([UIColor class])])   // 如果当前参数是为了设定颜色的，则换成正常的颜色
                {
                    UIColor *argumentColor = [UIColor colorWithIdentifier:argString];
                    [invocation setArgument:&argumentColor atIndex:2 + i];
                    // 在这里必须缓存一下，因为出了当前的作用域改color对象就会被ARC自动的release，而在下面invocation还会retain一下参数，就会导致野指针出现
                    // 后面的argumentImage也是一个意思
                    [tempArguments addObject:argumentColor];
                }
                else if ([argString.themeTransferType isEqualToString:NSStringFromClass([UIImage class])])  // 如果当前的参数是为了设定图片的，则换成正常的图片
                {
                    UIImage *argumentImage = [UIImage imageWithIdentifier:argString];
                    [invocation setArgument:&argumentImage atIndex:2 + i];
                    [tempArguments addObject:argumentImage];
                }
                else
                {
                    [invocation setArgument:&argString atIndex:2 + i];
                }
            }
            else
            {
                [invocation setArgument:&currentArgument atIndex:2 + i];
            }
        }
    }
    
    [invocation retainArguments];
    [invocation invokeWithTarget:self];
}

- (void)cacheParams:(NSArray *)params forSelector:(NSString *)selName
{
    [self registerThemeChangeNotification];
    
    /*
     缓存的方式是使用字典嵌套的方式
     {
        设定的方法名 : [
                    [参数列表]， //
                ]
     }
     */
    NSMutableArray *cachedParams = [self.themeProperties objectForKey:selName];
    
    if (!cachedParams)
    {
        cachedParams = [[NSMutableArray alloc] init];
        
        [self.themeProperties setObject:cachedParams forKey:selName];
    }
    
    [cachedParams addObject:params];
    
    [self performSelectorWithName:selName params:params];
}

- (void)updateTheme
{
    for (NSString *selName in [self.themeProperties allKeys])
    {
        for (NSArray *params in self.themeProperties[selName])
        {
            [self performSelectorWithName:selName params:params];
        }
    }
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


@end
