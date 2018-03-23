//
//  APPCustomAppearanceModel.m
//  DynamicTheme
//
//  Created by 胡金友 on 2018/3/23.
//

#import "APPCustomAppearanceModel.h"
#import "APPAppearanceManager.h"
#import <objc/runtime.h>

@interface APPCustomAppearanceModel()

@property (nonatomic, copy, readwrite) NSString *appearanceIdentifier;

@end

@implementation APPCustomAppearanceModel

+ (instancetype)apperanceWithIdentifier:(NSString *)identifier {
    return [[[self alloc] init] appearanceIdentifier:identifier];
}

- (id)correctParam {
    return [APPAppearanceManager sharedManager].appearancesInfo[self.appearanceIdentifier];
}

#pragma mark - APPAppearanceParamProtocol

- (instancetype)appearanceIdentifier:(NSString *)identifier {
    self.appearanceIdentifier = identifier;
    return self;
}

@end
