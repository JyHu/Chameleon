//
//  APPAppearanceManager.m
//  DynamicTheme
//
//  Created by 胡金友 on 2018/3/23.
//

#import "APPAppearanceManager.h"
#import "APPAppearanceManager+_Private.h"
#import "UIColor+AUUAppearance.h"
#import "NSObject+APPAppearance.h"


#if defined(__has_include) && __has_include(<SDWebImage/SDWebImageDownloader.h>)  // 防止外部是使用动态库添加的
#define HasSD
#import <SDWebImage/SDWebImageDownloader.h>
#elif defined(__has_include) && __has_include("SDWebImageDownloader.h")  // 防止外部是直接拷贝到项目中去的
#define HasSD
#import "SDWebImageDownloader.h"
#else
#error "没有添加SDWebImage，添加SDWebImage以后，error自动消失"
#endif

NSString *const APPThemeChangeNotification = @"com.jyhu.APPThemeChangeNotification";


@interface APPAppearanceManager()

@property (nonatomic, strong) NSDictionary *cachedThemeInfoDict;
@property (nonatomic, copy) NSString *cachedThemeSourcePath;

@property (nonatomic, strong, readwrite) UIColor *defaultColor;
@property (nonatomic, strong, readwrite) UIImage *defaultImage;

@end

@implementation APPAppearanceManager

+ (instancetype)sharedManager {
    static APPAppearanceManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[APPAppearanceManager alloc] init];
    });
    return manager;
}

- (instancetype)init {
    if ((self = [super init])) {
        self.defaultColor = [UIColor app_randomColor];
        self.defaultImage = nil;
    }
    
    return self;
}

- (BOOL)changeThemeWithSourcePath:(NSString *)sourcePath themeInfo:(NSDictionary *)themeInfo {
    // MARK: 添加对themeInfo的判断
    self.cachedThemeSourcePath = sourcePath;
    self.cachedThemeInfoDict = themeInfo;
    
    [self performThemeChanged];
    
    return YES;
}

- (void)performThemeChanged {
    // iOS 9以下的通知中心不支持自动释放，所以使用MapTable，只有在iOS9以后才使用通知
    if (@available(iOS 9.0, *)) {
        [[NSNotificationCenter defaultCenter] postNotificationName:APPThemeChangeNotification object:nil];
    } else {
        for (NSObject *appKit in self.appRefrences.objectEnumerator) {
            [appKit performAllCachedSelector];
        }
    }
}

- (void)webImageWithURLString:(NSString *)imgURLString
           downloadCompletion:(void (^)(UIImage *))completion {
    
    if (!imgURLString) {
        return;
    }
    
    if (self.appearanceDelegate && [self.appearanceDelegate respondsToSelector:@selector(webImageWithURLString:downloadCompletion:)]) {
        
        [self.appearanceDelegate webImageWithURLString:imgURLString downloadCompletion:completion];
    } else {
        // 使用SDWebImage去下载图片
        SDWebImageDownloaderCompletedBlock completeBlock =
        ^(UIImage * _Nullable image, NSData * _Nullable data,
          NSError * _Nullable error, BOOL finished) {
            completion(image);
        };
        
        SDWebImageDownloader *downloader = [SDWebImageDownloader sharedDownloader];
        
        [downloader downloadImageWithURL:[NSURL URLWithString:imgURLString]
                                 options:SDWebImageDownloaderHighPriority
                                progress:nil
                               completed:completeBlock];
    }
}

- (void)registerDefaultColor:(UIColor *)color {
    self.defaultColor = color;
}

- (void)registerDefaultImage:(UIImage *)image {
    self.defaultImage = image;
}

- (NSDictionary *)colorsInfo {
    return self.appearanceDelegate ? self.appearanceDelegate.colorsInfo : self.cachedThemeInfoDict[@"colors"];
}

- (NSDictionary *)imagesInfo {
    return self.appearanceDelegate ? self.appearanceDelegate.imagesInfo : self.cachedThemeInfoDict[@"images"];
}

- (NSDictionary *)appearancesInfo {
    return self.appearanceDelegate ? self.appearanceDelegate.appearancesInfo : self.cachedThemeInfoDict[@"appearance"];
}

- (NSString *)currentThemePath {
    return self.appearanceDelegate ? self.appearanceDelegate.currentThemePath : _cachedThemeSourcePath;
}

- (UIImage *)defaultImage {
    if (self.appearanceDelegate && [self.appearanceDelegate respondsToSelector:@selector(defaultImage)]) {
        return self.appearanceDelegate.defaultImage ?: _defaultImage;
    }
    return _defaultImage;
}

- (UIColor *)defaultColor {
    if (self.appearanceDelegate && [self.appearanceDelegate respondsToSelector:@selector(defaultColor)]) {
        return self.appearanceDelegate.defaultColor ?: _defaultColor;
    }
    return _defaultColor;
}

- (NSMapTable *)appRefrences {
    if (!_appRefrences) {
        _appRefrences = [[NSMapTable alloc] initWithKeyOptions:NSPointerFunctionsCopyIn valueOptions:NSPointerFunctionsWeakMemory capacity:100];
    }
    return _appRefrences;
}

@end
