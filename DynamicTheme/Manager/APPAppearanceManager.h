//
//  APPAppearanceManager.h
//  DynamicTheme
//
//  Created by 胡金友 on 2018/3/23.
//

#import <UIKit/UIKit.h>


extern NSString *const APPThemeChangeNotification;


@protocol APPAppearanceDelegate <NSObject>

@required

@property (nonatomic, strong, readonly) NSDictionary *colorsInfo;
@property (nonatomic, strong, readonly) NSDictionary *imagesInfo;
@property (nonatomic, strong, readonly) NSDictionary *appearancesInfo;

@property (nonatomic, copy, readonly) NSString *currentThemePath;

@optional

@property (nonatomic, strong, readonly) UIColor *defaultColor;
@property (nonatomic, strong, readonly) UIImage *defaultImage;

@end

@interface APPAppearanceManager : NSObject <APPAppearanceDelegate>

/**
 单例
 
 @return self
 */
+ (instancetype)sharedManager;

/**
 留给外部管理皮肤属性的代理
 */
@property (weak, nonatomic) id <APPAppearanceDelegate> appearanceDelegate;

/**
 更换主题
 
 @param sourcePath 主题资源的目录
 @param themeInfo 主题的详细信息
 */
- (BOOL)changeThemeWithSourcePath:(NSString *)sourcePath themeInfo:(NSDictionary *)themeInfo;

- (void)registerDefaultImage:(UIImage *)image;
- (void)registerDefaultColor:(UIColor *)color;

@end
