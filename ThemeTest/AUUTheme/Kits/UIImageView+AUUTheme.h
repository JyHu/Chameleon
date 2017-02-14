//
//  UIImageView+AUUTheme.h
//  ThemeTest
//
//  Created by JyHu on 2017/2/14.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (AUUTheme)

- (void)setImageWithIdentifier:(NSString *)imageIdentifier;

- (void)setHighlightedImageWithIdentifier:(NSString *)highlightedImageIdentifier;

@end
