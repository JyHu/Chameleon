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

public extension NSObject {
    
}

/// 提供方便的缓存执行换肤方法的各项参数
///
/// 目前最多支持6个入参
public extension NSObject {
    @discardableResult
    func cache<A>(
        valA: Callable.Param<A>,
        identifier: AppearanceCallableIdentifier,
        action: @escaping ((
            Callable.Param<A>
        ) -> Void)
    ) -> Callable.One<A> {
        let callable = Callable.One(firstParam: valA, identifier: identifier, action: action)
        cache(appearanceCallable: callable)
        return callable
    }
    
    @discardableResult
    func cache<A, B>(
        valA: Callable.Param<A>,
        valB: Callable.Param<B>,
        identifier: AppearanceCallableIdentifier,
        action: @escaping ((
            Callable.Param<A>,
            Callable.Param<B>
        ) -> Void)
    ) -> Callable.Two<A, B> {
        let callable = Callable.Two(
            firstParam: valA,
            secondParam: valB,
            identifier: identifier,
            action: action
        )
        cache(appearanceCallable:callable)
        return callable
    }
    
    @discardableResult
    func cache<A, B, C>(
        valA: Callable.Param<A>,
        valB: Callable.Param<B>,
        valC: Callable.Param<C>,
        identifier: AppearanceCallableIdentifier,
        action: @escaping ((
            Callable.Param<A>,
            Callable.Param<B>,
            Callable.Param<C>
        ) -> Void)
    ) -> Callable.Three<A, B, C> {
            let callable = Callable.Three(
                firstParam: valA,
                secondParam: valB,
                thirdParam: valC,
                identifier: identifier,
                action: action
            )
        cache(appearanceCallable:callable)
            return callable
    }
    
    @discardableResult
    func cache<A, B, C, D>(
        valA: Callable.Param<A>,
        valB: Callable.Param<B>,
        valC: Callable.Param<C>,
        valD: Callable.Param<D>,
        identifier: AppearanceCallableIdentifier,
        action: @escaping ((
            Callable.Param<A>,
            Callable.Param<B>,
            Callable.Param<C>,
            Callable.Param<D>
        ) -> Void)
    ) -> Callable.Four<A, B, C, D> {
        let callable = Callable.Four(
            firstParam: valA,
            secondParam: valB,
            thirdParam: valC,
            fourthParam: valD,
            identifier: identifier,
            action: action
        )
        cache(appearanceCallable:callable)
        return callable
    }
    
    @discardableResult
    func cache<A, B, C, D, E>(
        valA: Callable.Param<A>,
        valB: Callable.Param<B>,
        valC: Callable.Param<C>,
        valD: Callable.Param<D>,
        valE: Callable.Param<E>,
        identifier: AppearanceCallableIdentifier,
        action: @escaping ((
            Callable.Param<A>,
            Callable.Param<B>,
            Callable.Param<C>,
            Callable.Param<D>,
            Callable.Param<E>
        ) -> Void)
    ) -> Callable.Five<A, B, C, D, E> {
        let callable = Callable.Five(
            firstParam: valA,
            secondParam: valB,
            thirdParam: valC,
            fourthParam: valD,
            fifthParam: valE,
            identifier: identifier,
            action: action
        )
        cache(appearanceCallable:callable)
        return callable
    }
    
    @discardableResult
    func cache<A, B, C, D, E, F>(
        valA: Callable.Param<A>,
        valB: Callable.Param<B>,
        valC: Callable.Param<C>,
        valD: Callable.Param<D>,
        valE: Callable.Param<E>,
        valF: Callable.Param<F>,
        identifier: AppearanceCallableIdentifier,
        action: @escaping ((
            Callable.Param<A>,
            Callable.Param<B>,
            Callable.Param<C>,
            Callable.Param<D>,
            Callable.Param<E>,
            Callable.Param<F>
        ) -> Void)
    ) -> Callable.Six<A, B, C, D, E, F> {
        let callable = Callable.Six(
            firstParam: valA,
            secondParam: valB,
            thirdParam: valC,
            fourthParam: valD,
            fifthParam: valE,
            sixthParam: valF,
            identifier: identifier,
            action: action
        )
        cache(appearanceCallable:callable)
        return callable
    }
}

public extension NSObject {
    @discardableResult
    func cache(appearanceCallable: CallableProtocol) -> CallableProtocol {
        var callables = cacher.cachedMethods[appearanceCallable.category] ?? [:]
        
        if callables[appearanceCallable.identifier] == nil {
            callables[appearanceCallable.identifier] = appearanceCallable
            cacher.cachedMethods[appearanceCallable.category] = callables
        }
        
        appearanceCallable.execute()
        
        Chameleon.shared.registerAppearanceObserver(self, action: #selector(performThemeChangedAction))
        
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
