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
#import "NSObject+AUUMethodCache.h"
#import "NSObject+DeallocObserver.h"

#if defined(__has_include) && __has_include(<SDWebImage/SDWebImageDownloader.h>)  // 防止外部是使用动态库添加的
#define HasSD
#import <SDWebImage/SDWebImageDownloader.h>
#elif defined(__has_include) && __has_include("SDWebImageDownloader.h")  // 防止外部是直接拷贝到项目中去的
#define HasSD
#import "SDWebImageDownloader.h"
#else
#error "没有添加SDWebImage，添加SDWebImage以后，error自动消失"
#endif

@interface NSObject (_AUUThemePrivate)

@property (assign, nonatomic) BOOL notificationRegistered;

@end

@implementation NSObject (AUUTheme)

- (void)cacheThemeParams:(NSArray *)params forSelector:(SEL)sel
{
    [self registerThemeChangeNotification];
    
    [self cacheParams:params forSelector:sel argTransfer:^id(id object, SEL sel, NSArray *params, NSUInteger argIndex, BOOL *skip) {
        
        // 取得当前位置的参数
        id arg = params[argIndex];
        
        // 处理颜色对象
        if ([arg isKindOfClass:[UIColor class]]) {
            if ([arg apperanceIdentifier]) {
                return [UIColor colorWithIdentifier:[arg apperanceIdentifier]] ?: arg;
            } else {
                return arg;
            }
        }
        
        // 处理图片对象
        if ([arg isKindOfClass:[UIImage class]]) {
            if ([arg apperanceIdentifier]) {
                NSString *imagePath = nil;
                UIImage *realImage = [UIImage imageWithIdentifier:[arg apperanceIdentifier] imageURLPath:&imagePath];
                
                if (realImage) {
                    return realImage;
                }
#ifdef HasSD
                else if (imagePath) {
                    // 如果是一个图片地址的话，就跳过，先来下载图片，下载完以后再去设置
                    *skip = YES;
                    
                    __weak typeof(self) weakSelf = self;
                    
                    // 使用SDWebImage去下载图片
                    SDWebImageDownloaderCompletedBlock completeBlock = ^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
                        __strong typeof(weakSelf) strongSelf = weakSelf;
                        
                        UIImage *destImage = image;
                        if (!destImage) {
                            destImage = arg;
                        }
                        NSMutableArray *mutableParams = [params mutableCopy];
                        [mutableParams replaceObjectAtIndex:argIndex withObject:destImage];
                        
                        [object performSelector:sel params:mutableParams hashCode:[strongSelf hashKeyForParams:params]];
                    };
                    
                    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:imagePath]
                                                                          options:SDWebImageDownloaderHighPriority
                                                                         progress:nil
                                                                        completed:completeBlock];
                    
                    return nil;
                }
#endif
                else {
                    return arg;
                }
            } else {
                return arg;
            }
        }
        
        if ([arg isKindOfClass:[AUUApperanceModel class]]) {
            AUUApperanceModel *apperanceModel = (AUUApperanceModel *)arg;
            return [AUUThemeManager sharedManager].themeInfos[@"appearance"][apperanceModel.apperanceIdentifier] ?: apperanceModel.defaultApperanceValue;
        }
        
        if ([arg isKindOfClass:[NSString class]]) {
            return [AUUThemeManager sharedManager].themeInfos[@"appearance"][arg] ?: arg;
        }
        
        return arg;
    }];
}

- (void)updateTheme {
    [self performAllCachedSelector];
}

- (void)registerThemeChangeNotification {
    // 只有在未设置的时候才需要来设置，避免重复设置
    if (!self.notificationRegistered) {
        self.notificationRegistered = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTheme) name:ThemeApperanceChangeNotification object:nil];
    }
}

- (void)setNotificationRegistered:(BOOL)notificationRegistered {
    objc_setAssociatedObject(self, @selector(notificationRegistered),
                             @(notificationRegistered), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)notificationRegistered {
    id obj = objc_getAssociatedObject(self, @selector(notificationRegistered));
    return obj ? [obj boolValue] : NO;
}

@end
