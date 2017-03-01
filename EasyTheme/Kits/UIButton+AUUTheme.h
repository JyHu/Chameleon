//
//  UIButton+AUUTheme.h
//  ThemeTest
//
//  Created by JyHu on 2017/2/14.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (AUUTheme)



@property (retain, nonatomic, readonly) NSArray *titleColorIdentifiers;
- (void)setTitleColorWithIdentifier:(NSString *)identifier forState:(UIControlState)state;



@property (retain, nonatomic, readonly) NSArray *imageIdentifiers;
- (void)setImageWithIdentifier:(NSString *)identifier forState:(UIControlState)state;



@property (retain, nonatomic, readonly) NSArray *backgroundImageIdentifiers;
- (void)setBackgroundImageWithIdentifier:(NSString *)identifier forState:(UIControlState)state;

@end
