//
//  NSString+APPAppearance.m
//  DynamicTheme
//
//  Created by 胡金友 on 2018/3/23.
//

#import "NSString+APPAppearance.h"

@implementation NSString (APPAppearance)

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
