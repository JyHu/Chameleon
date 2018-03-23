//
//  APPCustomAppearanceModel.h
//  DynamicTheme
//
//  Created by 胡金友 on 2018/3/23.
//

#import <Foundation/Foundation.h>
#import "APPAppearanceParamProtocol.h"

/*
 一些自定义的属性
 */

@interface APPCustomAppearanceModel : NSObject <APPAppearanceParamProtocol>

+ (instancetype)apperanceWithIdentifier:(NSString *)identifier;

- (id)correctParam;

@end
