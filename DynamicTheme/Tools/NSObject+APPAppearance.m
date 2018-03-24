//
//  NSObject+APPAppearance.m
//  DynamicTheme
//
//  Created by 胡金友 on 2018/3/23.
//

#import "NSObject+APPAppearance.h"

#import "APPAppearanceManager.h"
#import "APPAppearanceManager+_Private.h"
#import "UIColor+APPAppearance.h"
#import "UIImage+APPAppearance.h"
#import "APPCustomAppearanceModel.h"

#import <objc/runtime.h>

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

@interface _APPMethodsInfo : NSObject
// 缓存的参数
@property (retain, nonatomic) NSArray *params;
// 参数的类型转换
@property (nonatomic) SEL invokeSelector;
@end
@implementation _APPMethodsInfo
+ (instancetype)infoWithParams:(NSArray *)params manualInvokeSelector:(SEL)invokeSelector {
    _APPMethodsInfo *info = [[_APPMethodsInfo alloc] init];
    info.params = params;
    info.invokeSelector = invokeSelector;
    return info;
}
@end

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

@interface NSObject (_APPThemePrivate)

@property (retain, nonatomic, readonly) NSMutableDictionary *cachedMethods;
@property (assign, nonatomic) BOOL notificationRegistered;

@end

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

@implementation NSObject (APPAppearance)

- (void)cacheThemeParams:(NSArray *)params forSelector:(SEL)sel {
    [self cacheThemeParams:params forSelector:sel manualInvokeSelector:nil];
}

- (void)cacheThemeParams:(NSArray *)params forSelector:(SEL)sel manualInvokeSelector:(SEL)invokeSelector {
    
    NSAssert(params && params.count > 0, @"参数列表设置不能为空");
    
    if (@available(iOS 9.0, *)) {
        [self registerThemeChangeNotification];
    } else {
        [[APPAppearanceManager sharedManager].appRefrences setObject:self forKey:[NSString stringWithFormat:@"%@_%@", NSStringFromClass([self class]), @([self hash])]];
    }
    NSMutableArray *cachedParams = [self.cachedMethods objectForKey:NSStringFromSelector(sel)];
    
    if (!cachedParams) {
        cachedParams = [[NSMutableArray alloc] init];
        [self.cachedMethods setObject:cachedParams forKey:NSStringFromSelector(sel)];
    }
    
    /*
     cachedMethods，当前类缓存的方法和参数列表
     {
         selname : {
             // 其中某个方法的参数列表，比如UIButton设置标题颜色，根据不同的状态，这个方法可以有好几种参数列表
             <<[p1, p2, p3], invokeSelector>>,
             <<[p1, p2], invokeSelector>>
         }
     }
     */
    
    if (params.count == 1) {
        [cachedParams removeAllObjects];
    }
    
    [cachedParams addObject:[_APPMethodsInfo infoWithParams:params manualInvokeSelector:invokeSelector]];
    
    [self performSelector:sel params:params manualInvokeSelector:invokeSelector];
}

- (void)performAllCachedSelector {
    for (NSString *selName in [self.cachedMethods allKeys]) {
        for (_APPMethodsInfo *info in self.cachedMethods[selName]) {
            [self performSelector:NSSelectorFromString(selName) params:info.params
             manualInvokeSelector:info.invokeSelector];
        }
    }
}

- (void)performSelector:(SEL)sel params:(NSArray *)params manualInvokeSelector:(SEL)invokeSelector {
    
    if (invokeSelector) {
        NSMethodSignature *signature = [[self class] instanceMethodSignatureForSelector:invokeSelector];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        invocation.selector = invokeSelector;
        
        if ([signature numberOfArguments] >= 3) {
            [invocation setArgument:&sel atIndex:2];
        }
        
        if ([signature numberOfArguments] >= 4) {
            [invocation setArgument:&params atIndex:3];
        }
        
        [invocation invokeWithTarget:self];
        
        return;
    }
    
    // https://opensource.apple.com/source/objc4/objc4-706/runtime/runtime.h.auto.html
    
    NSMethodSignature   *signature      = [[self class] instanceMethodSignatureForSelector:sel];
    NSInvocation        *invocation     = [NSInvocation invocationWithMethodSignature:signature];
    NSMutableArray      *tempArguments  = [[NSMutableArray alloc] init];  // 暂存一些对象，避免zombie
    
    invocation.selector = sel;
    
    for (unsigned int i = 2; i < [signature numberOfArguments]; i ++) {
        
        if (i >= params.count + 2) {
            continue;
        }
        
        /*
         用于获取方法的参数类型
         方法原型：
         void method_getArgumentType(Method m, unsigned int index, char *dst, size_t dst_len)
         index 从i+2开始是因为:
         在运行时方法的执行都是走的objc_msgSend(Class cls, SEL sel, ....)，前两个参数都是固定的表示类本身和方法名，所以参数是从第三个（即index = 2）开始。
         在下面设定参数的时候也是必须要从index=2开始
         http://www.auu.space/2016/04/30/iOS方法调用之NSInvocation/
         */
        
        BOOL skip = NO;
        
        id correctArgument = [self correctParamInSelector:sel params:params argIndex:i - 2 skip:&skip
                                  manualInvokeSelector:invokeSelector];
        
        if (skip) {
            return;
        }
        
        if (correctArgument) {
            [tempArguments addObject:correctArgument];
        } else {
            continue;
        }
        
        const char *type = [signature getArgumentTypeAtIndex:i];
        
        // https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html#//apple_ref/doc/uid/TP40008048-CH100-SW1
        
        if (strcmp(type, "#") == 0) {          // Class
            Class argumentCls = NSClassFromString(correctArgument);
            [invocation setArgument:&argumentCls atIndex:i];
        }
        else if (strcmp(type, ":") == 0) {     // Selector
            SEL argumentSEL = NSSelectorFromString(correctArgument);
            [invocation setArgument:&argumentSEL atIndex:i];
        }
        else if (strcmp(type, "c") == 0) {    // Char
            char argumentC = [correctArgument charValue];
            [invocation setArgument:&argumentC atIndex:i];
        }
        else if (strcmp(type, "C") == 0) {
            unsigned char argumentUC = [correctArgument unsignedCharValue];
            [invocation setArgument:&argumentUC atIndex:i];
        }
        else if (strcmp(type, "s") == 0) {
            short argumentS = [correctArgument shortValue];
            [invocation setArgument:&argumentS atIndex:i];
        }
        else if (strcmp(type, "S") == 0) {
            unsigned short argumentUS = [correctArgument unsignedShortValue];
            [invocation setArgument:&argumentUS atIndex:i];
        }
        else if (strcmp(type, "i") == 0) {
            int argumentI = [correctArgument intValue];
            [invocation setArgument:&argumentI atIndex:i];
        }
        else if (strcmp(type, "I") == 0) {
            NSUInteger argumentUI = [correctArgument unsignedIntegerValue];
            [invocation setArgument:&argumentUI atIndex:i];
        }
        else if (strcmp(type, "l") == 0) {
            long argumentL = [correctArgument longValue];
            [invocation setArgument:&argumentL atIndex:i];
        }
        else if (strcmp(type, "L") == 0) {
            unsigned long argumentUL = [correctArgument unsignedLongValue];
            [invocation setArgument:&argumentUL atIndex:i];
        }
        else if (strcmp(type, "q") == 0) {
            long long argumentLL = [correctArgument longLongValue];
            [invocation setArgument:&argumentLL atIndex:i];
        }
        else if (strcmp(type, "Q") == 0) {
            unsigned long long argumentULL = [correctArgument unsignedLongLongValue];
            [invocation setArgument:&argumentULL atIndex:i];
        }
        else if (strcmp(type, "f") == 0) {
            float argumentF = [correctArgument floatValue];
            [invocation setArgument:&argumentF atIndex:i];
        }
        else if (strcmp(type, "d") == 0) {
            double argumentD = [correctArgument doubleValue];
            [invocation setArgument:&argumentD atIndex:i];
        }
        else if (strcmp(type, "b") == 0 || strcmp(type, "B") == 0) {
            BOOL argumentB = [correctArgument boolValue];
            [invocation setArgument:&argumentB atIndex:i];
        }
        else if (type && sizeof(type) / sizeof(const char *) > 0) {  // 是对象或其他数据类型
            [invocation setArgument:&correctArgument atIndex:i];
        }
    }
    
    [invocation retainArguments];
    [invocation invokeWithTarget:self];
}

- (id)correctParamInSelector:(SEL)sel params:(NSArray *)params
                    argIndex:(NSUInteger)index skip:(BOOL *)skip
        manualInvokeSelector:(SEL)invokeSelector {
    
    if (!params || params.count == 0) {
        return nil;
    }
    
    // 取得当前位置的参数
    id currentArgument = params[index];
    
    // 处理颜色对象
    if ([currentArgument isKindOfClass:[UIColor class]]) {
        return [currentArgument correctColor];
    }
    
    // 处理图片对象
    if ([currentArgument isKindOfClass:[UIImage class]]) {
        NSString *imagePath = nil;
        UIImage *tempImage = [currentArgument correctImageWithURLString:&imagePath];
        
        // 找到了正确的图片可以直接返回
        if (tempImage) {
            return tempImage;
        }
        
        // 如果没有正确的图片且没有图片的url地址，则把当前的图片返回过去
        if (!imagePath) {
            return currentArgument;
        }
        
        // 如果是一个图片地址的话，就跳过，先来下载图片，下载完以后再去设置
        *skip = YES;
        
        __weak typeof(self) weakSelf = self;
        // 下载图片
        [[APPAppearanceManager sharedManager] webImageWithURLString:imagePath downloadCompletion:^(UIImage *image) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (image) {
                // 图片下载完成以后再次的执行设置方法
                NSMutableArray *mutableParams = [params mutableCopy];
                [mutableParams replaceObjectAtIndex:index withObject:image];
                
                [strongSelf performSelector:sel params:mutableParams manualInvokeSelector:invokeSelector];
            }
        }];
        
        return nil;
    }
    
    if ([currentArgument isKindOfClass:[APPCustomAppearanceModel class]]) {
        return [currentArgument correctParam];
    }
    
    return currentArgument;
}

- (void)registerThemeChangeNotification {
    // 只有在未设置的时候才需要来设置，避免重复设置
    if (!self.notificationRegistered) {
        self.notificationRegistered = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(performAllCachedSelector) name:APPThemeChangeNotification object:nil];
    }
}

- (id)cachedParamForSelector:(SEL)selector {
    NSArray *params = [self.cachedMethods objectForKey:NSStringFromSelector(selector)];
    _APPMethodsInfo *methodInfo = [params firstObject];
    return [methodInfo.params firstObject];
}

#pragma mark - GETTER & SETTER

- (void)setNotificationRegistered:(BOOL)notificationRegistered {
    objc_setAssociatedObject(self, @selector(notificationRegistered),
                             @(notificationRegistered), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)notificationRegistered {
    id obj = objc_getAssociatedObject(self, @selector(notificationRegistered));
    return obj ? [obj boolValue] : NO;
}

const char *kCachedMethodsAssociatedKey = (void *)@"com.jyhu.kcachedMethodsAssociatedKey";

- (NSMutableDictionary *)cachedMethods {
    NSMutableDictionary *mutableDictionary = objc_getAssociatedObject(self, kCachedMethodsAssociatedKey);
    if (!mutableDictionary) {
        mutableDictionary = [[NSMutableDictionary alloc] init];
        objc_setAssociatedObject(self, kCachedMethodsAssociatedKey, mutableDictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return mutableDictionary;
}

@end

