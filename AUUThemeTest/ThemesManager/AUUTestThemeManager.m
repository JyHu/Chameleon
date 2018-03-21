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

@property (retain, nonatomic) NSMutableDictionary *pri_themesDict;

@property (retain, nonatomic) NSString *pri_currentThemeIdentifier;

@end

@implementation AUUTestThemeManager

+ (void)load {
    [[self sharedManager] loadThemes];
    [[self sharedManager] loadSettingTheme];
}

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
        self.pri_themesDict = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (void)loadThemes
{
    // 本地的主题，默认是以bundle的形式存放在本地
    [self.pri_themesDict setObject:[AUUThemeModel modelWithName:@"白色主题"
                                                       path:[[NSBundle mainBundle] pathForResource:@"white" ofType:@"json"]
                                                 identifier:@"com.jyhu.theme.white"] forKey:@"com.jyhu.theme.white"];
    
    [self.pri_themesDict setObject:[AUUThemeModel modelWithName:@"紫色主题"
                                                       path:[[NSBundle mainBundle] pathForResource:@"pupurse" ofType:@"json"]
                                                 identifier:@"com.jyhu.theme.black"] forKey:@"com.jyhu.theme.black"];
    
    [self.pri_themesDict setObject:[AUUThemeModel modelWithName:@"粉红主题"
                                                           path:[[NSBundle mainBundle] pathForResource:@"lightred" ofType:@"json"]
                                                     identifier:@"com.jyhu.lightred"] forKey:@"com.jyhu.lightred"];
    
    [self.pri_themesDict setObject:[AUUThemeModel modelWithName:@"淡蓝主题"
                                                           path:[[NSBundle mainBundle] pathForResource:@"lightblue" ofType:@"json"]
                                                     identifier:@"com.jyhu.lightblue"] forKey:@"com.jyhu.lightblue"];
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
    AUUThemeModel *themeModel = self.pri_themesDict[identifier];
    NSString *jsonPath = themeModel.themePath;
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:jsonPath])
    {
        NSLog(@"file not exists");
        return NO;
    }
    
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    NSDictionary *theme = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    [[AUUThemeManager sharedManager] changeThemeWithSourcePath:themeModel.themePath themeInfo:theme];
    
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

- (NSDictionary *)themesDict
{
    return self.pri_themesDict;
}

@end
