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
#import "NSObject+Apperance.h"
#import "NSObject+DeallocObserver.h"
#import "NSString+AUUTheme.h"
#import "UIColor+AUUTheme.h"
#import "UIImage+AUUTheme.h"
#import "AUUThemeManager.h"

#if defined(__has_include) && __has_include(<SDWebImage/SDWebImageDownloader.h>)  // 防止外部是使用动态库添加的
#define HasSD
#import <SDWebImage/SDWebImageDownloader.h>
#elif defined(__has_include) && __has_include("SDWebImageDownloader.h")  // 防止外部是直接拷贝到项目中去的
#define HasSD
#import "SDWebImageDownloader.h"
#else
#error "没有添加SDWebImage，添加SDWebImage以后，error自动消失"
#endif


//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
//                  private mode for method cache
//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
@interface _AUUMethodsInfo : NSObject

+ (instancetype)infoWithParams:(NSArray *)params argTransfer:(AUUArgumentTransfer)argTransfer;
// 缓存的参数
@property (retain, nonatomic) NSArray *params;
// 参数的类型转换
@property (copy, nonatomic) AUUArgumentTransfer argTransfer;
@end
@implementation _AUUMethodsInfo
+ (instancetype)infoWithParams:(NSArray *)params argTransfer:(AUUArgumentTransfer)argTransfer {
    _AUUMethodsInfo *info = [[_AUUMethodsInfo alloc] init];
    info.params = params;
    info.argTransfer = [argTransfer copy];
    return info;
}
@end


//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


@interface NSObject (_AUUThemePrivate)

@property (retain, nonatomic, readonly) NSMutableDictionary *cachedMethods;
@property (assign, nonatomic) BOOL notificationRegistered;

@end

@implementation NSObject (AUUTheme)

- (void)cacheThemeParams:(NSArray *)params forSelector:(SEL)sel {
    [self registerThemeChangeNotification];
    [self cacheThemeParams:params forSelector:sel argumentTransfer:nil];
}

- (void)cacheThemeParams:(NSArray *)params forSelector:(SEL)sel argumentTransfer:(AUUArgumentTransfer)transfer {
    NSMutableDictionary *cachedParams = [self.cachedMethods objectForKey:NSStringFromSelector(sel)];
    
    if (!cachedParams) {
        cachedParams = [[NSMutableDictionary alloc] init];
        [self.cachedMethods setObject:cachedParams forKey:NSStringFromSelector(sel)];
    }
    
    /*
     cachedMethods，当前类缓存的方法和参数列表
     {
         selname : {
            // 其中某个方法的参数列表，比如UIButton设置标题颜色，根据不同的状态，这个方法可以有好几种参数列表
             hash : <<[p1, p2, p3], transfer>>,
             hash : <<[p1, p2], transfer>>
         }
     }
     */
    
    [cachedParams setObject:[_AUUMethodsInfo infoWithParams:params argTransfer:transfer] forKey:[self hashKeyForParams:params]];
    
    [self performSelector:sel params:params argTransfer:transfer];
}

- (void)performSelector:(SEL)sel params:(NSArray *)params hashCode:(NSString *)hashCode {
    NSDictionary *sels = self.cachedMethods[NSStringFromSelector(sel)];
    _AUUMethodsInfo *methodInfo = sels ? sels[hashCode] : nil;
    [self performSelector:sel params:params argTransfer: methodInfo ? methodInfo.argTransfer : nil];
}

- (void)performAllCachedSelector {
    [self performAllCachedSelectorWithArgumentTransfer:nil];
}

- (void)performAllCachedSelectorWithArgumentTransfer:(AUUArgumentTransfer)transfer {
    for (NSString *selName in [self.cachedMethods allKeys]) {
        for (_AUUMethodsInfo *info in [self.cachedMethods[selName] allValues]) {
            [self performSelector:NSSelectorFromString(selName) params:info.params argTransfer:info.argTransfer];
        }
    }
}

- (void)performSelector:(SEL)sel params:(NSArray *)params argTransfer:(AUUArgumentTransfer)transfer {
    // https://opensource.apple.com/source/objc4/objc4-706/runtime/runtime.h.auto.html
    
    NSMethodSignature   *signature      = [[self class] instanceMethodSignatureForSelector:sel];
    NSInvocation        *invocation     = [NSInvocation invocationWithMethodSignature:signature];
    NSMutableArray      *tempArguments  = [[NSMutableArray alloc] init];  // 暂存一些对象，避免zombie
    
    invocation.selector = sel;
    
    for (unsigned int i = 0; i < params.count; i ++) {
        /*
         用于获取方法的参数类型
         方法原型：
         void method_getArgumentType(Method m, unsigned int index, char *dst, size_t dst_len)
         index 从i+2开始是因为:
         在运行时方法的执行都是走的objc_msgSend(Class cls, SEL sel, ....)，前两个参数都是固定的表示类本身和方法名，所以参数是从第三个（即index = 2）开始。
         在下面设定参数的时候也是必须要从index=2开始
         http://www.auu.space/2016/04/30/iOS方法调用之NSInvocation/
         */
        
        id correctArgument = params[i];
        
        {
            __weak typeof(self) weakSelf = self;
            BOOL skip = NO;
            id tempArg = nil;
            
            if (transfer) {
                tempArg = transfer(weakSelf, sel, params, i, &skip);
            } else {
                tempArg = [self correctParamInSelector:sel params:params argIndex:i skip:&skip];
            }
            
            if (tempArg) {
                correctArgument = tempArg;
            }
            
            if (skip) {
                return;
            }
            
            [tempArguments addObject:correctArgument];
        }
        
        const char *type = [signature getArgumentTypeAtIndex:i + 2];
        
        if (strcmp(type, "#") == 0) {          // Class
            Class argumentCls = NSClassFromString(correctArgument);
            [invocation setArgument:&argumentCls atIndex:2 + i];
        }
        else if (strcmp(type, ":") == 0) {     // Selector
            SEL argumentSEL = NSSelectorFromString(correctArgument);
            [invocation setArgument:&argumentSEL atIndex:2 + i];
        }
        else if (strcmp(type, "c") == 0) {    // Char
            char argumentC = [correctArgument charValue];
            [invocation setArgument:&argumentC atIndex:2 + i];
        }
        else if (strcmp(type, "C") == 0) {
            unsigned char argumentUC = [correctArgument unsignedCharValue];
            [invocation setArgument:&argumentUC atIndex:2 + i];
        }
        else if (strcmp(type, "s") == 0) {
            short argumentS = [correctArgument shortValue];
            [invocation setArgument:&argumentS atIndex:2 + i];
        }
        else if (strcmp(type, "S") == 0) {
            unsigned short argumentUS = [correctArgument unsignedShortValue];
            [invocation setArgument:&argumentUS atIndex:2 + i];
        }
        else if (strcmp(type, "i") == 0) {
            int argumentI = [correctArgument intValue];
            [invocation setArgument:&argumentI atIndex:2 + i];
        }
        else if (strcmp(type, "I") == 0) {
            NSUInteger argumentUI = [correctArgument unsignedIntegerValue];
            [invocation setArgument:&argumentUI atIndex:2 + i];
        }
        else if (strcmp(type, "l") == 0) {
            long argumentL = [correctArgument longValue];
            [invocation setArgument:&argumentL atIndex:2 + i];
        }
        else if (strcmp(type, "L") == 0) {
            unsigned long argumentUL = [correctArgument unsignedLongValue];
            [invocation setArgument:&argumentUL atIndex:2 + i];
        }
        else if (strcmp(type, "q") == 0) {
            long long argumentLL = [correctArgument longLongValue];
            [invocation setArgument:&argumentLL atIndex:2 + i];
        }
        else if (strcmp(type, "Q") == 0) {
            unsigned long long argumentULL = [correctArgument unsignedLongLongValue];
            [invocation setArgument:&argumentULL atIndex:2 + i];
        }
        else if (strcmp(type, "f") == 0) {
            float argumentF = [correctArgument floatValue];
            [invocation setArgument:&argumentF atIndex:2 + i];
        }
        else if (strcmp(type, "d") == 0) {
            double argumentD = [correctArgument doubleValue];
            [invocation setArgument:&argumentD atIndex:2 + i];
        }
        else if (strcmp(type, "b") == 0 || strcmp(type, "B") == 0) {
            BOOL argumentB = [correctArgument boolValue];
            [invocation setArgument:&argumentB atIndex:2 + i];
        }
        else if (type && sizeof(type) / sizeof(const char *) > 0) {  // 是对象或其他数据类型
            [invocation setArgument:&correctArgument atIndex:2 + i];
        }
    }
    
    [invocation retainArguments];
    [invocation invokeWithTarget:self];
}

- (id)correctParamInSelector:(SEL)sel params:(NSArray *)params argIndex:(NSUInteger)index skip:(BOOL *)skip {
    if (!params || params.count == 0) {
        return nil;
    }
    
    // 取得当前位置的参数
    id currentArgument = params[index];
    
    // 处理颜色对象
    if ([currentArgument isKindOfClass:[UIColor class]]) {
        if ([currentArgument apperanceIdentifier]) {
            return [UIColor colorWithIdentifier:[currentArgument apperanceIdentifier]] ?: currentArgument;
        } else {
            return currentArgument;
        }
    }
    
    // 处理图片对象
    if ([currentArgument isKindOfClass:[UIImage class]]) {
        if ([currentArgument apperanceIdentifier]) {
            NSString *imagePath = nil;
            UIImage *realImage = [UIImage imageWithIdentifier:[currentArgument apperanceIdentifier] imageURLPath:&imagePath];
            
            if (realImage) {
                return realImage;
            } else if (imagePath) {
                // 如果是一个图片地址的话，就跳过，先来下载图片，下载完以后再去设置
                *skip = YES;
                
                __weak typeof(self) weakSelf = self;
                
                // 使用SDWebImage去下载图片
                SDWebImageDownloaderCompletedBlock completeBlock = ^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
                    __strong typeof(weakSelf) strongSelf = weakSelf;
                    
                    UIImage *destImage = image;
                    if (!destImage) {
                        destImage = currentArgument;
                    }
                    NSMutableArray *mutableParams = [params mutableCopy];
                    [mutableParams replaceObjectAtIndex:index withObject:destImage];
                    
                    [strongSelf performSelector:sel params:mutableParams hashCode:[strongSelf hashKeyForParams:params]];
                };
                
                [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:imagePath]
                                                                      options:SDWebImageDownloaderHighPriority
                                                                     progress:nil
                                                                    completed:completeBlock];
                
                return nil;
            } else {
                return currentArgument;
            }
        } else {
            return currentArgument;
        }
    }
    
    if ([currentArgument isKindOfClass:[AUUApperanceModel class]]) {
        AUUApperanceModel *apperanceModel = (AUUApperanceModel *)currentArgument;
        return [AUUThemeManager sharedManager].themeInfos[@"appearance"][apperanceModel.apperanceIdentifier] ?: apperanceModel.defaultApperanceValue;
    }
    
    if ([currentArgument isKindOfClass:[NSString class]]) {
        return [AUUThemeManager sharedManager].themeInfos[@"appearance"][currentArgument] ?: currentArgument;
    }
    
    return currentArgument;
}

- (NSString *)hashKeyForParams:(NSArray *)params {
    NSUInteger hashValue = 0;
    
    for (id param in params) {
        hashValue += [param hash];
    }
    
    return [NSString stringWithFormat:@"%@", @(hashValue)];
}

- (void)registerThemeChangeNotification {
    // 只有在未设置的时候才需要来设置，避免重复设置
    if (!self.notificationRegistered) {
        self.notificationRegistered = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(performAllCachedSelector) name:ThemeApperanceChangeNotification object:nil];
    }
}

- (id)cachedParamForSelector:(SEL)selector {
    NSDictionary *params = [self.cachedMethods objectForKey:NSStringFromSelector(selector)];
    _AUUMethodsInfo *methodInfo = [[params allValues] firstObject];
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
