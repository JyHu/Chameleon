//
//  AUUTestThemeManager.h
//  ThemeTest
//
//  Created by 胡金友 on 2017/2/23.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AUUTestThemeManager : NSObject

+ (instancetype)sharedManager;

- (void)changeThemeWithIdentifier:(NSString *)themeIdentifier;

@end
