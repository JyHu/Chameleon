//
//  UIColor+Helper.m
//  AUUThemeTest
//
//  Created by 胡金友 on 2018/3/20.
//

#import "UIColor+Helper.h"

@implementation UIColor (Helper)

+ (instancetype)textTitleColor {
    return [[UIColor blackColor] appearanceIdentifier:AUUColorTextTitle];
}

+ (instancetype)backgroundColor {
    return [[UIColor whiteColor] appearanceIdentifier:AUUColorBackground];
}

+ (instancetype)vcBackgroundColor {
    return [[UIColor whiteColor] appearanceIdentifier:AUUColorBackgroundVC];
}

+ (instancetype)tableBackgroundColor {
    return [[UIColor whiteColor] appearanceIdentifier:AUUColorBackgroundTable];
}

+ (instancetype)textColor {
    return [[UIColor blackColor] appearanceIdentifier:AUUColorText];
}

+ (instancetype)normalTextColor {
    return [[UIColor grayColor] appearanceIdentifier:AUUColorTextNormal];
}

+ (instancetype)hightlightedTextColor {
    return [[UIColor redColor] appearanceIdentifier:AUUColorTextHighlighted];
}

+ (instancetype)selectedTextColor {
    return [[UIColor greenColor] appearanceIdentifier:AUUColorTextSelected];
}

+ (instancetype)subtitleColor {
    return [[UIColor darkGrayColor] appearanceIdentifier:AUUColorTextSubtitle];
}

@end
