//
//  UITableView+APPAppearance.m
//  DynamicTheme
//
//  Created by 胡金友 on 2018/3/23.
//

#import "UITableView+APPAppearance.h"
#import "NSObject+APPAppearance.h"

@implementation UITableView (APPAppearance)

- (void)setApp_separatorColor:(UIColor *)app_separatorColor {
    APPColorParamAssert(app_separatorColor)
    [self cacheThemeParams:@[app_separatorColor] forSelector:@selector(setSeparatorColor:)];
}

- (UIColor *)app_separatorColor {
    return [self cachedParamForSelector:@selector(setSeparatorColor:)];
}

@end
