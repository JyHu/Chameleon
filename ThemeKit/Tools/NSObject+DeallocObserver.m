//
//  NSObject+DeallocObserver.m
//  ThemeKit
//
//  Created by 胡金友 on 2018/3/20.
//

#import "NSObject+DeallocObserver.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface _AUUDeallocObserverObject : NSObject
@property (copy, nonatomic) AUUDeallocObserver observer;
@end
@implementation _AUUDeallocObserverObject
@end

static NSMutableSet *app_swizzledClasses() {
    static dispatch_once_t onceToken;
    static NSMutableSet *app_swizzledClasses = nil;
    dispatch_once(&onceToken, ^{
        app_swizzledClasses = [[NSMutableSet alloc] init];
    });
    
    return app_swizzledClasses;
}

const char *AUUObjectWillDeallocKey = (void *)@"AUUObjectWillDeallocKey";

static void app_swizzleDeallocIfNeeded(Class classToSwizzle ) {
    @synchronized (app_swizzledClasses()) {
        NSString *className = NSStringFromClass(classToSwizzle);
        if ([app_swizzledClasses() containsObject:className]) return;
        
        SEL deallocSelector = sel_registerName("dealloc");
        
        __block void (*originalDealloc)(__unsafe_unretained id, SEL) = NULL;
        
        id newDealloc = ^(__unsafe_unretained id self) {
            
            _AUUDeallocObserverObject *object = objc_getAssociatedObject(self, AUUObjectWillDeallocKey);
            if (object && object.observer) {
                object.observer(self);
            }
            
            if (originalDealloc == NULL) {
                struct objc_super superInfo = {
                    .receiver = self,
                    .super_class = class_getSuperclass(classToSwizzle)
                };
                
                void (*msgSend)(struct objc_super *, SEL) = (__typeof__(msgSend))objc_msgSendSuper;
                msgSend(&superInfo, deallocSelector);
            } else {
                originalDealloc(self, deallocSelector);
            }
        };
        
        IMP newDeallocIMP = imp_implementationWithBlock(newDealloc);
        
        if (!class_addMethod(classToSwizzle, deallocSelector, newDeallocIMP, "v@:")) {
            // The class already contains a method implementation.
            Method deallocMethod = class_getInstanceMethod(classToSwizzle, deallocSelector);
            
            // We need to store original implementation before setting new implementation
            // in case method is called at the time of setting.
            originalDealloc = (__typeof__(originalDealloc))method_getImplementation(deallocMethod);
            
            // We need to store original implementation again, in case it just changed.
            originalDealloc = (__typeof__(originalDealloc))method_setImplementation(deallocMethod, newDeallocIMP);
        }
        
        [app_swizzledClasses() addObject:className];
    }
}

@implementation NSObject (DeallocObserver)

- (void)subscribeDealloc:(AUUDeallocObserver)observer {
    @synchronized(self) {
        _AUUDeallocObserverObject *object = objc_getAssociatedObject(self, AUUObjectWillDeallocKey);
        if (object == nil) {
            app_swizzleDeallocIfNeeded(self.class);
            
            object = [[_AUUDeallocObserverObject alloc] init];
            objc_setAssociatedObject(self, AUUObjectWillDeallocKey, object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            object.observer = observer;
        }
    }
}


@end
