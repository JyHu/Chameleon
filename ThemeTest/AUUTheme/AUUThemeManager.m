//
//  AUUThemeManager.m
//  ThemeTest
//
//  Created by JyHu on 2017/2/13.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "AUUThemeManager.h"
#import "AUUThemeModel.h"

@interface AUUThemeManager()

@property (retain, nonatomic) NSString *pri_changeThemeNotification;

@property (retain, nonatomic) NSString *pri_currentThemeIdentifier;

@end

@implementation AUUThemeManager

singleton_m(Manager)

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        self.defaultColor = [UIColor redColor];
        self.defaultImage = [UIImage new];
        [self loadThemes];
        [self loadSettingTheme];
    }
    
    return self;
}

- (void)loadThemes
{
    self.pri_changeThemeNotification = @"com.jyhu.notification.themechanged";
    
    NSString *localBlack = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"LocalBlackTheme.bundle"];
    NSString *localWhite = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"LocalWhiteTheme.bundle"];
    
    // 本地的主题，默认是以bundle的形式存放在本地
    
    [self.themeList addObject:[AUUThemeModel themeWithName:@"白色主题"
                                                      path:[localWhite stringByAppendingPathComponent:@"Contents/Resources"]
                                                identifier:@"com.jyhu.theme.white" type:AUUThemeTypeLocal]];
    
    [self.themeList addObject:[AUUThemeModel themeWithName:@"黑色主题"
                                                      path:[localBlack stringByAppendingPathComponent:@"Contents/Resources"]
                                                identifier:@"com.jyhu.theme.black" type:AUUThemeTypeLocal]];
}

- (void)loadSettingTheme
{
    NSString *themeIdentifier = [[NSUserDefaults standardUserDefaults] objectForKey:@"com.jyhu.cachedThemeIdentifier"];
    
    if (themeIdentifier)
    {
        [self loadThemeInfoWithIdentifier:themeIdentifier];
    }
}

- (BOOL)loadThemeInfoWithIdentifier:(NSString *)identifier
{
    NSString *jsonPath = [[self getThemeWithIdentifier:identifier].themePath stringByAppendingPathComponent:@"theme.json"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:jsonPath])
    {
        NSLog(@"file not exists");
        return NO;
    }
    
    self.pri_currentThemeIdentifier = identifier;
    
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    NSError *error;
    self.themeInfos = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    
    return YES;
}

- (void)changeThemeWithIdentifier:(NSString *)themeIdentifier
{
    if (themeIdentifier && self.pri_currentThemeIdentifier && [themeIdentifier isEqualToString:self.pri_currentThemeIdentifier])
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
    
    [[NSNotificationCenter defaultCenter] postNotificationName:self.pri_changeThemeNotification object:nil];
}

- (AUUThemeModel *)getThemeWithIdentifier:(NSString *)identifier
{
    for (AUUThemeModel *themeModel in self.themeList)
    {
        if ([themeModel.themeIdentifier isEqualToString:identifier])
        {
            return themeModel;
        }
    }
    
    return nil;
}

#pragma mark - getter

- (NSMutableArray *)themeList
{
    if (!_themeList)
    {
        _themeList = [[NSMutableArray alloc] init];
    }
    
    return _themeList;
}

- (NSString *)changeThemeNotification
{
    return self.pri_changeThemeNotification;
}

- (NSString *)currentThemeIdentifier
{
    return self.pri_currentThemeIdentifier;
}

- (NSString *)currentThemeSourcePath
{
    return [self getThemeWithIdentifier:self.currentThemeIdentifier].themePath;
}

@end
