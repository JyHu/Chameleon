//
//  AUUPagerViewController.h
//  ThemeTest
//
//  Created by JyHu on 2017/2/24.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import <THSegmentedPager/THSegmentedPager.h>

@interface AUUPagerViewController : THSegmentedPager

- (instancetype)initWithPages:(NSArray *)pages containerInsets:(UIEdgeInsets)insets;
- (instancetype)initWithPages:(NSArray *)pages;

@end
