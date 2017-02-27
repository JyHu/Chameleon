//
//  UIImageView+AUUTheme.h
//  ThemeTest
//
//  Created by JyHu on 2017/2/14.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (AUUTheme)

@property (retain, nonatomic, setter=setImageIdentifier:) NSString *imageIdentifier;

@property (retain, nonatomic, setter=setImageColorIdentifier:) NSString *imageColorIdentifier;

@property (retain, nonatomic, setter=setHighlightedImageIdentifier:) NSString *highlightedImageIdentifier;

@end
