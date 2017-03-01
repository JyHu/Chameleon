//
//  AUUThemeModel.h
//  ThemeTest
//
//  Created by 胡金友 on 2017/2/23.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AUUThemeModel : NSObject

+ (instancetype)modelWithName:(NSString *)name path:(NSString *)path identifier:(NSString *)identifier;

@property (retain, nonatomic) NSString *themeIdentifier;

@property (retain, nonatomic) NSString *themePath;

@property (retain, nonatomic) NSString *themeName;

@end
