//
//  UITextView+AUUTheme.h
//  ThemeTest
//
//  Created by JyHu on 2017/2/14.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (AUUTheme)

@property (retain, nonatomic, setter=setTintColorIdentifier:) NSString *tintColorIdentifier;

@property (retain, nonatomic, setter=setTextColorIdentifier:) NSString *textColorIdentifier;

@end
