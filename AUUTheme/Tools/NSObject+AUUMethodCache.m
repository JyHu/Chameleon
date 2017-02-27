//
//  NSObject+AUUMethodCache.m
//  ThemeTest
//
//  Created by 胡金友 on 2017/2/21.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "NSObject+AUUMethodCache.h"
#import <objc/runtime.h>


#import "NSString+AUUTheme.h"
#import "UIColor+AUUTheme.h"
#import "UIImage+AUUTheme.h"


#import "NSDictionary+AUUMethodCache.h"
#import "NSObject+__AUUPrivate.h"

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//                  private mode for method cache
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
@interface _AUUMethodsInfo : NSObject

+ (instancetype)infoWithParams:(NSArray *)params argTransfer:(AUUArgumentTransfer)argTransfer;

@property (retain, nonatomic) NSArray *params;

@property (copy, nonatomic) AUUArgumentTransfer argTransfer;

@end

@implementation _AUUMethodsInfo

+ (instancetype)infoWithParams:(NSArray *)params argTransfer:(AUUArgumentTransfer)argTransfer
{
    _AUUMethodsInfo *info = [[_AUUMethodsInfo alloc] init];
    
    info.params = params;
    info.argTransfer = [argTransfer copy];
    
    return info;
}

@end

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//                  private property for method cache
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

@interface NSObject (_AUUPrivate)

@property (retain, nonatomic) NSMutableDictionary *cachedMethods;

@end

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

@implementation NSObject (AUUMethodCache)

- (id)cacheParams:(NSArray *)params forSelector:(SEL)sel
{
    return [self cacheParams:params forSelector:sel argTransfer:nil];
}

- (id)cacheParams:(NSArray *)params forSelector:(SEL)sel argTransfer:(AUUArgumentTransfer)transfer
{
    NSMutableDictionary *cachedParams = [self.cachedMethods objectForKey:NSStringFromSelector(sel)];
    
    if (!cachedParams)
    {
        cachedParams = [[NSMutableDictionary alloc] init];
        
        [self.cachedMethods setObject:cachedParams forKey:NSStringFromSelector(sel)];
    }
    
    /*
     cachedMethods，当前类缓存的方法和参数列表
     {
        selname : {     // 其中某个方法的参数列表
            hash : <<[p1, p2, p3], transfer>>,
            hash : <<[p1, p2], transfer>>
        }
     }
     */
    NSString *hashKey = [self hashKeyForParams:params];
    
    [cachedParams setObject:[_AUUMethodsInfo infoWithParams:params argTransfer:transfer] forKey:hashKey];
    
    return [@{NSStringFromSelector(sel) : params} setPerformerWithTarget:self];
}

- (void)performSelector:(SEL)sel params:(NSArray *)params
{
    [self performSelector:sel params:params hashCode:[self hashKeyForParams:params]];
}

- (void)performSelector:(SEL)sel params:(NSArray *)params hashCode:(NSString *)hashCode
{
    NSDictionary *sels = self.cachedMethods[NSStringFromSelector(sel)];
    _AUUMethodsInfo *methodInfo = sels ? sels[hashCode] : nil;
    [self performSelector:sel params:params argTransfer: methodInfo ? methodInfo.argTransfer : nil];
}

- (void)performAllCachedSelector
{
    [self performAllCachedSelectorWithArgumentTransfer:nil];
}

- (void)performAllCachedSelectorWithArgumentTransfer:(AUUArgumentTransfer)transfer
{
    for (NSString *selName in [self.cachedMethods allKeys])
    {
        for (_AUUMethodsInfo *info in [self.cachedMethods[selName] allValues])
        {
            [self performSelector:NSSelectorFromString(selName) params:info.params argTransfer:info.argTransfer];
        }
    }
}

- (void)performSelector:(SEL)sel params:(NSArray *)params argTransfer:(AUUArgumentTransfer)transfer
{
    // https://opensource.apple.com/source/objc4/objc4-706/runtime/runtime.h.auto.html
    
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
        
        id correctArgument = params[i];
        
        if (transfer)
        {
            __weak id weakSelf = self;
            BOOL skip = NO;
            correctArgument = transfer(weakSelf, sel, params, i, &skip);
            if (skip) {
                return;
            }
            [tempArguments addObject:correctArgument];
        }
        
        // 顾虑掉无效的空白部分
        NSString *octype = [[NSString stringWithUTF8String:type] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
        
        if ([octype isEqualToString:@"#"])          // Class
        {
            Class argumentCls = NSClassFromString(correctArgument);
            [invocation setArgument:&argumentCls atIndex:2 + i];
        }
        else if ([octype isEqualToString:@":"])     // Selector
        {
            SEL argumentSEL = NSSelectorFromString(correctArgument);
            [invocation setArgument:&argumentSEL atIndex:2 + i];
        }
        else if ([octype isEqualToString:@"c"])     // Char
        {
            char argumentC = [correctArgument charValue];
            [invocation setArgument:&argumentC atIndex:2 + i];
        }
        else if ([octype isEqualToString:@"C"])
        {
            unsigned char argumentUC = [correctArgument unsignedCharValue];
            [invocation setArgument:&argumentUC atIndex:2 + i];
        }
        else if ([octype isEqualToString:@"s"])
        {
            short argumentS = [correctArgument shortValue];
            [invocation setArgument:&argumentS atIndex:2 + i];
        }
        else if ([octype isEqualToString:@"S"])
        {
            unsigned short argumentUS = [correctArgument unsignedShortValue];
            [invocation setArgument:&argumentUS atIndex:2 + i];
        }
        else if ([octype isEqualToString:@"i"])
        {
            int argumentI = [correctArgument intValue];
            [invocation setArgument:&argumentI atIndex:2 + i];
        }
        else if ([octype isEqualToString:@"I"])
        {
            NSUInteger argumentUI = [correctArgument unsignedIntegerValue];
            [invocation setArgument:&argumentUI atIndex:2 + i];
        }
        else if ([octype isEqualToString:@"l"])
        {
            long argumentL = [correctArgument longValue];
            [invocation setArgument:&argumentL atIndex:2 + i];
        }
        else if ([octype isEqualToString:@"L"])
        {
            unsigned long argumentUL = [correctArgument unsignedLongValue];
            [invocation setArgument:&argumentUL atIndex:2 + i];
        }
        else if ([octype isEqualToString:@"q"])
        {
            long long argumentLL = [correctArgument longLongValue];
            [invocation setArgument:&argumentLL atIndex:2 + i];
        }
        else if ([octype isEqualToString:@"Q"])
        {
            unsigned long long argumentULL = [correctArgument unsignedLongLongValue];
            [invocation setArgument:&argumentULL atIndex:2 + i];
        }
        else if ([octype isEqualToString:@"f"])
        {
            float argumentF = [correctArgument floatValue];
            [invocation setArgument:&argumentF atIndex:2 + i];
        }
        else if ([octype isEqualToString:@"d"])
        {
            double argumentD = [correctArgument doubleValue];
            [invocation setArgument:&argumentD atIndex:2 + i];
        }
        else if ([octype isEqualToString:@"b"] || [octype isEqualToString:@"B"])
        {
            BOOL argumentB = [correctArgument boolValue];
            [invocation setArgument:&argumentB atIndex:2 + i];
        }
        else if (octype && octype.length > 0)   // 是对象或其他数据类型
        {
            [invocation setArgument:&correctArgument atIndex:2 + i];
        }
    }
    
    [invocation retainArguments];
    [invocation invokeWithTarget:self];
}

- (NSArray *)cachedParamsForSelector:(SEL)sel
{
    NSDictionary *paramsDict = self.cachedMethods[NSStringFromSelector(sel)];
    NSMutableArray *params = [NSMutableArray new];
    
    for (_AUUMethodsInfo *info in [paramsDict allValues])
    {
        [params addObject:info.params];
    }
    
    return params;
}

#pragma mark - associated getter and setter

const char *kCachedMethodsAssociatedKey = (void *)@"kcachedMethodsAssociatedKey";

- (void)setCachedMethods:(NSMutableDictionary *)cachedMethods
{
    objc_setAssociatedObject(self, kCachedMethodsAssociatedKey, cachedMethods, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)cachedMethods
{
    NSMutableDictionary *mutableDictionary = objc_getAssociatedObject(self, kCachedMethodsAssociatedKey);
    
    if (!mutableDictionary)
    {
        mutableDictionary = [[NSMutableDictionary alloc] init];
        [self setCachedMethods:mutableDictionary];
    }
    
    return mutableDictionary;
}

const char *kCachedPropertiesAssociatedKey = (void *)@"kCachedPropertiesAssociatedKey";

- (void)setCachedProperties:(id)cachedProperties
{
    objc_setAssociatedObject(self, kCachedMethodsAssociatedKey, cachedProperties, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)cachedProperties
{
    return objc_getAssociatedObject(self, kCachedMethodsAssociatedKey);
}

@end
