//
//  File.swift
//  
//
//  Created by Jo on 2023/4/2.
//

import Foundation

private extension NSObject {
    struct AssociationKey {
        static var cachedMethodsAssociationKey = "com.auu.chameleon.associationKey.cachedMethods"
    }
    
    class Cacher {
        var cachedMethods: [AppearanceCallableCategory: Dictionary<AppearanceCallableIdentifier, CallableProtocol>] = [:]
        var disableChameleon: Bool = false
    }
    
    var cacher: Cacher {
        get {
            var cacher = objc_getAssociatedObject(self, &AssociationKey.cachedMethodsAssociationKey) as? Cacher
            
            if cacher == nil {
                cacher = Cacher()
                objc_setAssociatedObject(self, &AssociationKey.cachedMethodsAssociationKey, cacher!, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
            
            return cacher!
        }
    }
}

/// 提供方便的缓存执行换肤方法的各项参数
///
/// 目前最多支持6个入参
public extension NSObject {
    @discardableResult
    func cache<A>(
        valA: A,
        identifier: AppearanceCallableIdentifier,
        action: @escaping ((A) -> Void),
        category: String = AppearanceDefaultCallableCategory
    ) -> Callable.One<A> {
        return cache(appearanceCallable: Callable.One(
            firstParam: valA,
            identifier: identifier,
            action: action,
            category: category
        ))
    }
    
    @discardableResult
    func cache<A, B>(
        valA: A, valB: B,
        identifier: AppearanceCallableIdentifier,
        action: @escaping ((A, B) -> Void),
        category: String = AppearanceDefaultCallableCategory
    ) -> Callable.Two<A, B> {
        return cache(appearanceCallable:Callable.Two(
            firstParam: valA,
            secondParam: valB,
            identifier: identifier,
            action: action,
            category: category
        ))
    }
    
    @discardableResult
    func cache<A, B, C>(
        valA: A, valB: B, valC: C,
        identifier: AppearanceCallableIdentifier,
        action: @escaping ((A, B, C) -> Void),
        category: String = AppearanceDefaultCallableCategory
    ) -> Callable.Three<A, B, C> {
        return cache(appearanceCallable:Callable.Three(
            firstParam: valA,
            secondParam: valB,
            thirdParam: valC,
            identifier: identifier,
            action: action,
            category: category
        ))
    }
    
    @discardableResult
    func cache<A, B, C, D>(
        valA: A, valB: B, valC: C, valD: D,
        identifier: AppearanceCallableIdentifier,
        action: @escaping ((A, B, C, D) -> Void),
        category: String = AppearanceDefaultCallableCategory
    ) -> Callable.Four<A, B, C, D> {
        return cache(appearanceCallable:Callable.Four(
            firstParam: valA,
            secondParam: valB,
            thirdParam: valC,
            fourthParam: valD,
            identifier: identifier,
            action: action,
            category: category
        ))
    }
    
    @discardableResult
    func cache<A, B, C, D, E>(
        valA: A, valB: B, valC: C, valD: D, valE: E,
        identifier: AppearanceCallableIdentifier,
        action: @escaping ((A, B, C, D, E) -> Void),
        category: String = AppearanceDefaultCallableCategory
    ) -> Callable.Five<A, B, C, D, E> {
        return cache(appearanceCallable:Callable.Five(
            firstParam: valA,
            secondParam: valB,
            thirdParam: valC,
            fourthParam: valD,
            fifthParam: valE,
            identifier: identifier,
            action: action,
            category: category
        ))
    }
}

public extension NSObject {
    func removeCallable(with identifier: AppearanceCallableIdentifier, category: String? = nil) {
        cacher.cachedMethods[category ?? AppearanceDefaultCallableCategory]?.removeValue(forKey: identifier)
    }
}

public extension NSObject {
    @discardableResult
    func cache<T>(appearanceCallable: T) -> T where T: CallableProtocol {
        if cacher.disableChameleon {
            appearanceCallable.execute()
            return appearanceCallable
        }
        
        var callables = cacher.cachedMethods[appearanceCallable.category] ?? [:]
        
        if callables[appearanceCallable.identifier] == nil {
            callables[appearanceCallable.identifier] = appearanceCallable
            cacher.cachedMethods[appearanceCallable.category] = callables
        }
        
        appearanceCallable.execute()
        
        AppearanceManager.shared.registerAppearanceObserver(self, action: #selector(performThemeChangedAction))
        
        return appearanceCallable
    }
}

private extension NSObject {
    @objc func performThemeChangedAction(_ notification: Notification) {
        for (_, callables) in cacher.cachedMethods {
            for (_, callable) in callables {
                callable.execute()
            }
        }
    }
}
