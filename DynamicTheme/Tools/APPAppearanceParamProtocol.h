//
//  APPAppearanceParamProtocol.h
//  DynamicTheme
//
//  Created by 胡金友 on 2018/3/23.
//

#import <Foundation/Foundation.h>

@protocol APPAppearanceParamProtocol <NSObject>

@property (nonatomic, copy, readonly) NSString *appearanceIdentifier;
- (instancetype)appearanceIdentifier:(NSString *)identifier;

@end
