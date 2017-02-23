//
//  AUUThemeModel.m
//  ThemeTest
//
//  Created by 胡金友 on 2017/2/23.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "AUUThemeModel.h"

@implementation AUUThemeModel

+ (instancetype)modelWithName:(NSString *)name path:(NSString *)path identifier:(NSString *)identifier
{
    AUUThemeModel *model = [[AUUThemeModel alloc] init];
    model.themeName = name;
    model.themePath = path;
    model.themeIdentifier = identifier;
    return model;
}

@end
