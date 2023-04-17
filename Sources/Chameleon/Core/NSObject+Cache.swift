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
        firstParam: A,
        identifier: AppearanceCallableIdentifier,
        action: @escaping ((A.InputType) -> Void),
        category: String = AppearanceDefaultCallableCategory
    ) -> Callable.One<A> where A: AppearancedProtocol {
        return cache(appearanceCallable: Callable.One(
            firstParam: firstParam,
            identifier: identifier,
            action: action,
            category: category
        ))
    }
    
    @discardableResult
    func cache<A, B>(
        firstParam: A, secondParam: B,
        identifier: AppearanceCallableIdentifier,
        action: @escaping ((A.InputType, B.InputType) -> Void),
        category: String = AppearanceDefaultCallableCategory
    ) -> Callable.Two<A, B> where A: AppearancedProtocol, B: AppearancedProtocol {
        return cache(appearanceCallable: Callable.Two(
            firstParam: firstParam,
            secondParam: secondParam,
            identifier: identifier,
            action: action,
            category: category
        ))
    }
    
    @discardableResult
    func cache<A, B, C>(
        firstParam: A, secondParam: B, thirdParam: C,
        identifier: AppearanceCallableIdentifier,
        action: @escaping ((A.InputType, B.InputType, C.InputType) -> Void),
        category: String = AppearanceDefaultCallableCategory
    ) -> Callable.Three<A, B, C> where A: AppearancedProtocol, B: AppearancedProtocol, C: AppearancedProtocol {
        return cache(appearanceCallable:Callable.Three(
            firstParam: firstParam,
            secondParam: secondParam,
            thirdParam: thirdParam,
            identifier: identifier,
            action: action,
            category: category
        ))
    }
    
    @discardableResult
    func cache<A, B, C, D>(
        firstParam: A, secondParam: B, thirdParam: C, fourthParam: D,
        identifier: AppearanceCallableIdentifier,
        action: @escaping ((A.InputType, B.InputType, C.InputType, D.InputType) -> Void),
        category: String = AppearanceDefaultCallableCategory
    ) -> Callable.Four<A, B, C, D> where A: AppearancedProtocol, B: AppearancedProtocol, C: AppearancedProtocol, D: AppearancedProtocol {
        return cache(appearanceCallable:Callable.Four(
            firstParam: firstParam,
            secondParam: secondParam,
            thirdParam: thirdParam,
            fourthParam: fourthParam,
            identifier: identifier,
            action: action,
            category: category
        ))
    }
    
    @discardableResult
    func cache<A, B, C, D, E>(
        firstParam: A, secondParam: B, thirdParam: C, fourthParam: D, fifthParam: E,
        identifier: AppearanceCallableIdentifier,
        action: @escaping ((A.InputType, B.InputType, C.InputType, D.InputType, E.InputType) -> Void),
        category: String = AppearanceDefaultCallableCategory
    ) -> Callable.Five<A, B, C, D, E> where A: AppearancedProtocol, B: AppearancedProtocol, C: AppearancedProtocol, D: AppearancedProtocol, E: AppearancedProtocol {
        return cache(appearanceCallable:Callable.Five(
            firstParam: firstParam,
            secondParam: secondParam,
            thirdParam: thirdParam,
            fourthParam: fourthParam,
            fifthParam: fifthParam,
            identifier: identifier,
            action: action,
            category: category
        ))
    }
}

public extension NSObject {
    
    /// 移除一个换肤方法执行对象
    /// - Parameters:
    ///   - identifier: 执行对象的唯一标识符
    ///   - category: 所属的分类
    func removeCallable(with identifier: AppearanceCallableIdentifier, category: AppearanceCallableCategory = AppearanceDefaultCallableCategory) {
        cacher.cachedMethods[category]?.removeValue(forKey: identifier)
    }
    
    /// 获取缓存的换肤方法执行对象
    /// - Parameters:
    ///   - identifier: 执行对象的唯一标识符
    ///   - category: 所属的分类
    /// - Returns: 查找到的缓存的对象
    func findCallable(with identifier: AppearanceCallableIdentifier, category: AppearanceCallableCategory = AppearanceDefaultCallableCategory) -> CallableProtocol? {
        return cacher.cachedMethods[category]?[identifier]
    }
}

public extension NSObject {
    
    /// 缓存一个换肤方法执行对象，缓存的同时会执行一次用于设置初始的皮肤属性
    /// - Parameter appearanceCallable: 换肤方法执行对象
    /// - Returns: 缓存的原始值
    @discardableResult
    func cache<T>(appearanceCallable: T) -> T where T: CallableProtocol {
#if DEBUG
        assert(Thread.current.isMainThread, "当前保存数据时不是在主线程")
#endif
        
        /// 如果当前不支持换肤，或者当前缓存的执行对象不支持换肤，那么就不执行缓存操作，
        /// 但是需要执行一下设置方法用于初始化UI显示
        if cacher.disableChameleon || !appearanceCallable.isAppearanced {
            appearanceCallable.execute(withoutChameleon: true)
            return appearanceCallable
        }
        
        var callables = cacher.cachedMethods[appearanceCallable.category] ?? [:]
        callables[appearanceCallable.identifier] = appearanceCallable
        cacher.cachedMethods[appearanceCallable.category] = callables
       
        appearanceCallable.execute(withoutChameleon: false)
        
        AppearanceManager.shared.registerAppearanceObserver(self, action: #selector(performThemeChangedAction))
        
        return appearanceCallable
    }
}

private extension NSObject {
    @objc func performThemeChangedAction(_ notification: Notification) {
        for (_, callables) in cacher.cachedMethods {
            for (_, callable) in callables {
                callable.execute(withoutChameleon: false)
            }
        }
    }
}
