//
//  APPAppearanceManager+_Private.h
//  DynamicTheme
//
//  Created by 胡金友 on 2018/3/23.
//

#import "APPAppearanceManager.h"

@interface APPAppearanceManager ()

/**
 在iOS9以下保存所有设置缓存属性的对象
 */
@property (nonatomic, strong) NSMapTable *appRefrences;

@end
