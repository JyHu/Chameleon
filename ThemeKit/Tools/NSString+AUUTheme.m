//
//  NSString+AUUTheme.m
//  ThemeTest
//
//  Created by 胡金友 on 2017/2/22.
//  Copyright © 2017年 JyHu. All rights reserved.
//

#import "NSString+AUUTheme.h"
#import <objc/runtime.h>
#import <UIKit/UIColor.h>
#import <UIKit/UIImage.h>

@implementation NSString (AUUTheme)

- (NSString *)matchResultWithPattern:(NSString *)pattern {
    NSError *rError;
    
    NSRegularExpression *regularExpression = [[NSRegularExpression alloc] initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&rError];
    
    if (rError) {
        return nil;
    }
    
    // 第一个匹配到的结果
    NSTextCheckingResult *textCheckingResult = [regularExpression firstMatchInString:self options:NSMatchingReportCompletion range:NSMakeRange(0, self.length)];
    
    if (textCheckingResult.numberOfRanges > 0) {
        NSRange range = [textCheckingResult rangeAtIndex:0];
        
        if (range.location != NSNotFound && range.length <= self.length) {
            return [self substringWithRange:range];
        }
    }
    
    return nil;
}

- (NSString *)superIdentifier {
    if (self && [self isKindOfClass:[NSString class]]) {
        NSString *tinyIdentifier = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        if (tinyIdentifier.length > 0) {
            NSRange range = [tinyIdentifier rangeOfString:@"." options:NSBackwardsSearch];
            
            if (range.location != NSNotFound) {
                return [tinyIdentifier substringToIndex:range.location];
            }
        }
    }
    
    return nil;
}

@end

