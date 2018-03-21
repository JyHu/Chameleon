//
//  NSObject+Apperance.h
//  ThemeKit
//
//  Created by 胡金友 on 2018/3/19.
//

#import <UIKit/UIKit.h>

@interface NSObject (Apperance)
@property (nonatomic, copy, readonly) NSString *apperanceIdentifier;
@end

@interface UIColor (Apperance)
- (instancetype)apperanceIdentifier:(NSString *)identifier;
@end

@interface UIImage (Apperance)
- (instancetype)apperanceIdentifier:(NSString *)identifier;
@end

@interface AUUApperanceModel : NSObject
+ (instancetype)apperanceIdentifier:(NSString *)identifier defaultValue:(id)value;
@property (nonatomic, weak, readonly) id defaultApperanceValue;
@end

