//
//  NSObject+APPAppearance.h
//  DynamicTheme
//
//  Created by 胡金友 on 2018/3/23.
//

#import <Foundation/Foundation.h>

#define APPColorParamAssert(param)     \
            NSString *astInfo = [NSString stringWithFormat:@"Error [%@] -%@",       \
                        NSStringFromClass([self class]), NSStringFromSelector(_cmd)];       \
            NSAssert(param && [param isKindOfClass:[UIColor class]], astInfo);

#define APPImageParamAssert(param)     \
            NSString *astInfo = [NSString stringWithFormat:@"Error [%@] -%@",        \
                        NSStringFromClass([self class]), NSStringFromSelector(_cmd)];        \
            NSAssert(param && [param isKindOfClass:[UIImage class]], astInfo);


@interface NSObject (APPAppearance)

/**
 缓存设置皮肤属性的方法

 @param params 方法的原始参数列表
 @param sel 设置属性的方法
 @param invokeSelector 丢给外部实现设置的方法
 
 @discuss invokeSelector
    支持动态设置参数个数，第一个参数是sel，第二个参数是params
    如：
        - (void)testSelector
        - (void)testSelector:(SEL)sel
        - (void)testSelector:(SEL)sel params:(NSArray *)params
 
 */
- (void)cacheThemeParams:(NSArray *)params forSelector:(SEL)sel manualInvokeSelector:(SEL)invokeSelector;
- (void)cacheThemeParams:(NSArray *)params forSelector:(SEL)sel;

/**
 缓存下来的参数

 @param selector 设置属性的方法
 @return 缓存的参数
 */
- (id)cachedParamForSelector:(SEL)selector;

/**
 执行缓存下来的所有方法
 */
- (void)performAllCachedSelector;

@end

