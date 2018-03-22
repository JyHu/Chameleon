//
//  NSObject+Apperance.m
//  ThemeKit
//
//  Created by 胡金友 on 2018/3/19.
//

#import "NSObject+Apperance.h"
#import <objc/runtime.h>
#import "AUUThemeManager.h"

@interface NSObject (_Apperance)

@property (nonatomic, copy, readwrite) NSString *apperanceIdentifier;

@end

@implementation NSObject (_Apperance)

- (instancetype)apperanceIdentifier:(NSString *)identifier {
    self.apperanceIdentifier = identifier;
    return self;
}

- (void)setApperanceIdentifier:(NSString *)identifier {
    objc_setAssociatedObject(self, @selector(apperanceIdentifier:), identifier, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)apperanceIdentifier {
    return objc_getAssociatedObject(self, @selector(apperanceIdentifier:));
}

@end

@implementation UIColor (Apperance)

- (instancetype)apperanceIdentifier:(NSString *)identifier {
    return [super apperanceIdentifier:identifier];
}

- (void)setApperanceIdentifier:(NSString *)apperanceIdentifier {
    [super setApperanceIdentifier:apperanceIdentifier];
}

@end

@implementation UIImage (Apperance)

- (instancetype)apperanceIdentifier:(NSString *)identifier {
    return [super apperanceIdentifier:identifier];
}

- (void)setApperanceIdentifier:(NSString *)apperanceIdentifier {
    [super setApperanceIdentifier:apperanceIdentifier];
}

@end

@interface AUUApperanceModel()
@property (nonatomic, weak, readwrite) id defaultApperanceValue;
@end
@implementation AUUApperanceModel
+ (instancetype)apperanceIdentifier:(NSString *)identifier defaultValue:(id)value {
    AUUApperanceModel *apperanceModel = [[[self alloc] init] apperanceIdentifier:identifier];
    apperanceModel.defaultApperanceValue = value;
    return apperanceModel;
}

- (id)correctParam {
    return [AUUThemeManager sharedManager].apperancesInfo[self.apperanceIdentifier] ?: self.defaultApperanceValue;
}
@end
