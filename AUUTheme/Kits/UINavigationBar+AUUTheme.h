//
//  UINavigationBar+AUUTheme.h
//  ThemeTest
//
//  Created by JyHu on 2017/2/25.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (AUUTheme)

@property (retain, nonatomic) NSString *titleColorIdentifier;

- (void)setBackgroundImageIdentifier:(NSString *)backgroundImageIdentifier forBarMetrics:(UIBarMetrics)barMetrics;

@end
