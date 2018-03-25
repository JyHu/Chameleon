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

// 所有的颜色信息
@property (nonatomic, strong, readonly) NSDictionary *colorsInfo;
// 所有的图片信息
@property (nonatomic, strong, readonly) NSDictionary *imagesInfo;
// 所有的自定义属性的信息
@property (nonatomic, strong, readonly) NSDictionary *appearancesInfo;

// 当前的资源文件路径
@property (nonatomic, copy, readonly) NSString *currentThemePath;

@optional

@property (nonatomic, strong, readonly) UIColor *defaultColor;
@property (nonatomic, strong, readonly) UIImage *defaultImage;

/**
 下载网络图片的方法

 @param imgURLString 图片的url地址
 @param completion 下载结束以后的回调
 */
- (void)webImageWithURLString:(NSString *)imgURLString
           downloadCompletion:(void (^)(UIImage *image))completion;

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

/**
 当换过主题以后调用的方法，如果调用的是`changeThemeWithSourcePath:themeInfo:`方法的话，
 就不用再调用这个方法，如果是外部管理皮肤属性的话，则需要调用这个方法通知内部更换皮肤属性
 */
- (void)performThemeChanged;

- (void)registerDefaultImage:(UIImage *)image;
- (void)registerDefaultColor:(UIColor *)color;

@end
