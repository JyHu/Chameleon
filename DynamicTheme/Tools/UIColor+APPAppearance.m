//
//  UIColor+APPAppearance.m
//  DynamicTheme
//
//  Created by 胡金友 on 2018/3/24.
//

#import "UIColor+APPAppearance.h"
#import "NSString+APPAppearance.h"
#import "APPAppearanceManager.h"
#import <objc/runtime.h>

@implementation UIColor (APPAppearance)

- (UIColor *)correctColor {
    if (self.appearanceIdentifier) {
        return [self colorWithIdentifier:self.appearanceIdentifier] ?: self;
    }
    
    return self;
}

- (UIColor *)colorWithIdentifier:(NSString *)identifier {
    
    if (!identifier) {
        return nil;
    }
    
    // 从主题中找到颜色信息，可以是string或者dict
    id colorInfo = [APPAppearanceManager sharedManager].colorsInfo[identifier];
    
    // 如果不存在颜色信息的话，则返回上一级的颜色信息
    if (!colorInfo) {
        return [self colorWithIdentifier:[identifier superIdentifier]];
    }
    
    // 如果是字符串，就当他是一个hex color字符串
    if ([colorInfo isKindOfClass:[NSString class]]) {
        return [UIColor app_colorWithHexString:colorInfo];
    }
    
    // 如果是字典，则直接去里面的 hex 字段作为hex color字符串
    // 可以为以后做兼容，用于返回更多的信息
    if ([colorInfo isKindOfClass:[NSDictionary class]]) {
        return [UIColor app_colorWithHexString:[colorInfo objectForKey:@"hex"]];
    }
    
    // 如果是其他的类型，则认为是类型错误
    return nil;
}

+ (UIColor *)app_randomColor {
    return [UIColor colorWithRed:arc4random_uniform(256) / 255.0
                           green:arc4random_uniform(256) / 255.0
                            blue:arc4random_uniform(256) / 255.0
                           alpha:1];
}

+ (UIColor *)app_colorWithHex:(NSUInteger)hex {
    // 带有alpha
    if (hex > (1 << 24) - 1)
    {
        return [UIColor colorWithRed:((hex & 0xFF000000) >> 24) / 255.0
                               green:((hex & 0xFF0000) >> 16) / 255.0
                                blue:((hex & 0xFF00) >> 8) / 255.0
                               alpha:(hex & 0xFF) / 255.0];
    }
    
    return [UIColor colorWithRed:((hex & 0xFF0000) >> 16) / 255.0
                           green:((hex & 0xFF00) >> 8) / 255.0
                            blue:( hex & 0xFF) / 255.0
                           alpha:1];
}

+ (UIColor *)app_colorWithHexString:(NSString *)hexString {
    if (hexString && [hexString isKindOfClass:[NSString class]] && hexString.length > 0) {
        unsigned int colorHexValue = 0;
        NSScanner *scanner = [NSScanner scannerWithString:hexString];
        [scanner setScanLocation:0];
        [scanner scanHexInt:&colorHexValue];
        
        return [UIColor app_colorWithHex:colorHexValue];
    }
    
    return nil;
}

#pragma mark - APPAppearanceParamProtocol

- (instancetype)appearanceIdentifier:(NSString *)identifier {
    objc_setAssociatedObject(self, @selector(appearanceIdentifier:),
                             identifier, OBJC_ASSOCIATION_COPY_NONATOMIC);
    return self;
}
- (NSString *)appearanceIdentifier {
    return objc_getAssociatedObject(self, @selector(appearanceIdentifier:));
}

@end

