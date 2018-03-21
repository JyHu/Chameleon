//
//  NSObject+DeallocObserver.h
//  ThemeKit
//
//  Created by 胡金友 on 2018/3/20.
//

#import <Foundation/Foundation.h>

typedef void (^AUUDeallocObserver) (__unsafe_unretained id self);

@interface NSObject (DeallocObserver)

- (void)subscribeDealloc:(AUUDeallocObserver)observer;

@end
