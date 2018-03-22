//
//  AUUThemeManager.h
//  ThemeTest
//
//  Created by JyHu on 2017/2/13.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


extern NSString *const ThemeApperanceChangeNotification;


@protocol AUUThemeManagerDelegate <NSObject>

@required

@property (nonatomic, strong, readonly) NSDictionary *colorsInfo;
@property (nonatomic, strong, readonly) NSDictionary *imagesInfo;
@property (nonatomic, strong, readonly) NSDictionary *apperancesInfo;

@property (nonatomic, copy, readonly) NSString *currentThemePath;

@property (nonatomic, strong, readonly) UIColor *defaultColor;
@property (nonatomic, strong, readonly) UIImage *defaultImage;

@end


@interface AUUThemeManager : NSObject <AUUThemeManagerDelegate>

/**
 单例

 @return self
 */
+ (instancetype)sharedManager;

@property (weak, nonatomic) id <AUUThemeManagerDelegate> themeDelegate;


#pragma mark - theme handle methods

/**
 更换主题

 @param sourcePath 主题资源的目录
 @param themeInfo 主题的详细信息
 */
- (BOOL)changeThemeWithSourcePath:(NSString *)sourcePath themeInfo:(NSDictionary *)themeInfo;

- (void)registerDefaultImage:(UIImage *)image;
- (void)registerDefaultColor:(UIColor *)color;


@end
