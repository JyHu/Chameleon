//
//  UISegmentedControl+AUUTheme.h
//  ThemeTest
//
//  Created by JyHu on 2017/2/14.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISegmentedControl (AUUTheme)

@property (retain, nonatomic, setter=setTintColorIdentifier:) NSString *tintColorIdentifier;

- (void)setImageWithIdentifier:(NSString *)imageIdentifier
             forSegmentAtIndex:(NSUInteger)segment;

@property (retain, nonatomic, readonly) NSArray *imageIdentifiersForSegments;

- (void)setBackgroundImageWithIdentifier:(NSString *)backgroundImageIdentifier
                                forState:(UIControlState)state barMetrics:(UIBarMetrics)barMetrics;

@property (retain, nonatomic, readonly) NSArray *backgroundImageIdentifiers;

- (void)setDividerImageWithIdentifier:(NSString *)dividerImageIdentifier
                  forLeftSegmentState:(UIControlState)leftState
                    rightSegmentState:(UIControlState)rightState barMetrics:(UIBarMetrics)barMetrics;

@property (retain, nonatomic, readonly) NSArray *dividerImageIdentifies;

@end
