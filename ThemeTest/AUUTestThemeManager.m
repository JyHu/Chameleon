//
//  AUUTestThemeManager.m
//  ThemeTest
//
//  Created by 胡金友 on 2017/2/23.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "AUUTestThemeManager.h"
#import "AUUThemeModel.h"
#import "AUUThemeManager.h"

@interface AUUTestThemeManager()

@property (retain, nonatomic) NSMutableDictionary *themesDict;

@property (retain, nonatomic) NSString *pri_currentThemeIdentifier;

@end

@implementation AUUTestThemeManager

+ (instancetype)sharedManager
{
    static AUUTestThemeManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AUUTestThemeManager alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    if ((self = [super init]))
    {
        self.themesDict = [[NSMutableDictionary alloc] init];
        [[AUUThemeManager sharedManager] registerThemeChangeNotification:@"themeChangeNotification"];
        [self loadThemes];
        [self loadSettingTheme];
    }
    
    return self;
}

- (void)loadThemes
{
    NSString *localBlack = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"LocalBlackTheme.bundle"];
    NSString *localWhite = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"LocalWhiteTheme.bundle"];
    
    // 本地的主题，默认是以bundle的形式存放在本地
    
    [self.themesDict setObject:[AUUThemeModel modelWithName:@"白色主题"
                                                       path:[localWhite stringByAppendingPathComponent:@"Contents/Resources"]
                                                 identifier:@"com.jyhu.theme.white"] forKey:@"com.jyhu.theme.white"];
    
    [self.themesDict setObject:[AUUThemeModel modelWithName:@"黑色主题"
                                                       path:[localBlack stringByAppendingPathComponent:@"Contents/Resources"]
                                                 identifier:@"com.jyhu.theme.black"] forKey:@"com.jyhu.theme.black"];
}

- (void)loadSettingTheme
{
    NSString *themeIdentifier = [[NSUserDefaults standardUserDefaults] objectForKey:@"com.jyhu.cachedThemeIdentifier"];
    
    if (!themeIdentifier)
    {
        themeIdentifier = @"com.jyhu.theme.white";
    }
    
    [self loadThemeInfoWithIdentifier:themeIdentifier];
}

- (BOOL)loadThemeInfoWithIdentifier:(NSString *)identifier
{
    AUUThemeModel *themeModel = self.themesDict[identifier];
    NSString *jsonPath = [themeModel.themePath stringByAppendingPathComponent:@"theme.json"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:jsonPath])
    {
        NSLog(@"file not exists");
        return NO;
    }
    
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    NSError *error;
    [[AUUThemeManager sharedManager] changeThemeWithSourcePath:themeModel.themePath
                                                     themeInfo:[NSJSONSerialization JSONObjectWithData:jsonData
                                                                                               options:NSJSONReadingMutableContainers error:&error]];
    
    return YES;
}

- (void)changeThemeWithIdentifier:(NSString *)themeIdentifier
{
    if (!themeIdentifier || (themeIdentifier && self.pri_currentThemeIdentifier && [themeIdentifier isEqualToString:self.pri_currentThemeIdentifier]))
    {
        return;
    }
    
    if (![self loadThemeInfoWithIdentifier:themeIdentifier])
    {
        NSLog(@"file not exists");
        return;
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:themeIdentifier forKey:@"com.jyhu.cachedThemeIdentifier"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
