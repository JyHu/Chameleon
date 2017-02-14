//
//  AUUThemeModel.h
//  ThemeTest
//
//  Created by JyHu on 2017/2/13.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, AUUThemeType) {
    AUUThemeTypeLocal,
    AUUThemeTypeShared,
    AUUThemeTypeNone,
};

@interface AUUThemeModel : NSObject

+ (instancetype)themeWithName:(NSString *)name path:(NSString *)path identifier:(NSString *)identifier;

+ (instancetype)themeWithName:(NSString *)name path:(NSString *)path identifier:(NSString *)identifier type:(AUUThemeType)type;

@property (retain, nonatomic) NSString *themeName;

@property (retain, nonatomic) NSString *themePath;

@property (retain, nonatomic) NSString *themeIdentifier;

@property (assign, nonatomic) AUUThemeType themeType;

@end
