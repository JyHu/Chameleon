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
#import "NSObject+__AUUPrivate.h"

#if defined(__has_include) && __has_include(<SDWebImage/SDWebImageDownloader.h>)  // 防止外部是使用动态库添加的
#define HasSD
#import <SDWebImage/SDWebImageDownloader.h>
#elif defined(__has_include) && __has_include("SDWebImageDownloader.h")  // 防止外部是直接拷贝到项目中去的
#define HasSD
#import "SDWebImageDownloader.h"
#else
#error "没有添加SDWebImage，添加SDWebImage以后，error自动消失"
#endif

void methodExchangeImplementations(Class cls, SEL originSelector, SEL swizedSelector)
{
    Method originMethod = class_getInstanceMethod(cls, originSelector);
    Method swizedMethod = class_getInstanceMethod(cls, swizedSelector);
    
    method_exchangeImplementations(swizedMethod, originMethod);
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

- (void)cacheThemeParams:(NSArray *)params forSelector:(SEL)sel
{
    [self registerThemeChangeNotification];
    
    [[self cacheParams:params forSelector:sel argTransfer:^id(id object, SEL sel, NSArray *params, NSUInteger argIndex, BOOL *skip) {
        
        id arg = params[argIndex];
        
        if ([arg isKindOfClass:[NSString class]])
        {
            NSString *argString = (NSString *)arg;
            
            if ([argString.themeTransferType isEqualToString:AUUThemeColorTypeString])   // 如果当前参数是为了设定颜色的，则换成正常的颜色
            {
                return [UIColor colorWithIdentifier:argString];
            }
            else if ([argString.themeTransferType isEqualToString:AUUThemeImageTypeString])  // 如果当前的参数是为了设定图片的，则换成正常的图片
            {
                
                NSString *imagePath = nil;
                UIImage *realImage = [UIImage imageWithIdentifier:argString imageURLPath:&imagePath];
                
                if (realImage)
                {
                    return realImage;
                }
#ifdef HasSD
                else if (imagePath)
                {
                    *skip = YES;
                    
                    SDWebImageDownloaderCompletedBlock completeBlock = ^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
                        NSMutableArray *mutableParams = [params mutableCopy];
                        [mutableParams replaceObjectAtIndex:argIndex withObject:image];
                        [object performSelector:sel params:mutableParams hashCode:[self hashKeyForParams:params]];
                    };
                    
                    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:imagePath]
                                                                          options:SDWebImageDownloaderHighPriority
                                                                         progress:nil
                                                                        completed:completeBlock];
                    
                    return nil;
                }
#endif
                else
                {
                    return [AUUThemeManager sharedManager].defaultImage;
                }
                
            }
            else if ([argString.themeTransferType isEqualToString:AUUThemeApperanceTypeString])
            {
                return [AUUThemeManager sharedManager].themeInfos[@"appearance"][argString];
            }
        }
        
        return arg;
    }] execute];
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
