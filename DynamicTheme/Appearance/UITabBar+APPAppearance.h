//
//  UITabBar+APPAppearance.h
//  DynamicTheme
//
//  Created by 胡金友 on 2018/3/23.
//

#import <UIKit/UIKit.h>

@interface UITabBar (APPAppearance)

@property (nonatomic, strong) UIColor *app_tintColor;
@property (nonatomic, strong) UIColor *app_barTintColor;
@property (nonatomic, strong) UIColor *app_unselectedItemTintColor;
@property (nonatomic, strong) UIColor *app_selectedImageTintColor;
@property (nonatomic, strong) UIImage *app_backgroundImage;
@property (nonatomic, strong) UIImage *app_selectionIndicatorImage;
@property (nonatomic, strong) UIImage *app_shadowImage;

@end
