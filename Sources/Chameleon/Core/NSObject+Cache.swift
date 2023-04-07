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
    
    /// 对当前组件禁止掉换肤支持
    var disableChameleon: Bool {
        set {
            cacher.disableChameleon = newValue
        }
        get {
            cacher.disableChameleon
        }
    }
}

/// 提供方便的缓存执行换肤方法的各项参数
///
/// - Parameters:
///   - valX: 缓存各个设置换肤属性方法的参数值，当前最多支持6个参数，再多也没啥意义
///   - identifier: 当前换肤执行对象的唯一值，为了唯一的区分一个换肤操作
///   - action: 执行换肤的时候执行的方法，用于设置正确的皮肤属性
///   - category: 当前方法的二级分类，比如UIButton可以用一个方法通过设置属性为不同的状态设
///       置图片，那么可以为每一个状态设置一个类别，在换肤的时候就不会乱
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
    func removeCallable(with identifier: AppearanceCallableIdentifier, category: AppearanceCallableCategory = AppearanceDefaultCallableCategory) {
        cacher.cachedMethods[category]?.removeValue(forKey: identifier)
    }
}

public extension NSObject {
    
    /// 缓存一个换肤方法执行对象，缓存的同时会执行一次用于设置初始的皮肤属性
    /// - Parameter appearanceCallable: 换肤方法执行对象
    /// - Returns: 缓存的原始值
    @discardableResult
    func cache<T>(appearanceCallable: T) -> T where T: CallableProtocol {
        if cacher.disableChameleon || !appearanceCallable.isAppearanced {
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
