//
//  UIColor+Helper.m
//  AUUThemeTest
//
//  Created by 胡金友 on 2018/3/20.
//

#import "UIColor+Helper.h"
#import "ThemeKit.h"

@implementation UIColor (Helper)

+ (instancetype)textTitleColor {
    return [[UIColor blackColor] apperanceIdentifier:AUUColorTextTitle];
}

+ (instancetype)backgroundColor {
    return [[UIColor whiteColor] apperanceIdentifier:AUUColorBackground];
}

+ (instancetype)vcBackgroundColor {
    return [[UIColor whiteColor] apperanceIdentifier:AUUColorBackgroundVC];
}

+ (instancetype)tableBackgroundColor {
    return [[UIColor whiteColor] apperanceIdentifier:AUUColorBackgroundTable];
}

+ (instancetype)textColor {
    return [[UIColor blackColor] apperanceIdentifier:AUUColorText];
}

+ (instancetype)normalTextColor {
    return [[UIColor grayColor] apperanceIdentifier:AUUColorTextNormal];
}

+ (instancetype)hightlightedTextColor {
    return [[UIColor redColor] apperanceIdentifier:AUUColorTextHighlighted];
}

+ (instancetype)selectedTextColor {
    return [[UIColor greenColor] apperanceIdentifier:AUUColorTextSelected];
}

+ (instancetype)subtitleColor {
    return [[UIColor darkGrayColor] apperanceIdentifier:AUUColorTextSubtitle];
}

@end
