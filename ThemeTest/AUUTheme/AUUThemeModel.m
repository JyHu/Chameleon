//
//  AUUThemeModel.m
//  ThemeTest
//
//  Created by JyHu on 2017/2/13.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "AUUThemeModel.h"

@implementation AUUThemeModel

+ (instancetype)themeWithName:(NSString *)name path:(NSString *)path identifier:(NSString *)identifier type:(AUUThemeType)type
{
    AUUThemeModel *model = [[AUUThemeModel alloc] init];
    
    model.themeName = name;
    model.themePath = path;
    model.themeIdentifier = identifier;
    model.themeType = type;
    
    return model;
}

+ (instancetype)themeWithName:(NSString *)name path:(NSString *)path identifier:(NSString *)identifier
{
    return [self themeWithName:name path:path identifier:identifier type:AUUThemeTypeShared];
}


@end
