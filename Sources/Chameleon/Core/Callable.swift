//
//  File.swift
//  
//
//  Created by Jo on 2023/4/3.
//

import Foundation

/// 换肤方法的执行对象
public protocol CallableProtocol {
    
    /// 当前执行对象的分类，可选值
    var category: AppearanceCallableCategory { get }
    
    /// 当前执行对象的唯一标识符，用于保证缓存执行对象只会存在一份
    var identifier: AppearanceCallableIdentifier { get }
    
    /// 在执行换肤的时候由框架内统一调用的方法，用于通知所有需要换肤的组件执行换肤的操作
    func execute(withoutChameleon: Bool)
    
    /// 当前缓存的换肤方法执行对象是否支持换肤，只要缓存的参数中有一个属性支持换肤，那么即算是支持
    /// 对于不支持换肤的执行对象，就没必要缓存
    var isAppearanced: Bool { get }
}

/// 可执行换肤方法对象的默认分组
public let AppearanceDefaultCallableCategory = "DefaultCategory"

public struct Callable { }

public extension Callable {
    
    /// 只有一个入参的换肤方法
    struct One<A>: CallableProtocol where A: AppearancedProtocol {
        public let identifier: AppearanceCallableIdentifier
        public let firstParam: A
        public let action: (A.InputType) -> Void
        public let category: AppearanceCallableCategory
        public var isAppearanced: Bool { return firstParam.isAppearanced }
        
        public init(
            firstParam: A,
            identifier: AppearanceCallableIdentifier,
            action: @escaping (A.InputType) -> Void,
            category: AppearanceCallableCategory = AppearanceDefaultCallableCategory
        ) {
            self.firstParam = firstParam
            self.identifier = identifier
            self.action = action
            self.category = category
        }
        
        public func execute(withoutChameleon: Bool) {
            if withoutChameleon {
                action(firstParam.original)
            } else {
                action(firstParam.correct)
            }
        }
    }
    
    /// 有两个入参的换肤方法
    struct Two<A, B>: CallableProtocol where A: AppearancedProtocol, B: AppearancedProtocol {
        public let identifier: AppearanceCallableIdentifier
        public let firstParam: A
        public let secondParam: B
        public let action: (A.InputType, B.InputType) -> Void
        public let category: AppearanceCallableCategory
        public var isAppearanced: Bool { firstParam.isAppearanced || secondParam.isAppearanced }
        
        public init(
            firstParam: A, secondParam: B,
            identifier: AppearanceCallableIdentifier,
            action: @escaping (A.InputType, B.InputType) -> Void,
            category: AppearanceCallableCategory = AppearanceDefaultCallableCategory
        ) {
            self.firstParam = firstParam
            self.secondParam = secondParam
            self.identifier = identifier
            self.action = action
            self.category = category
        }
        
        public func execute(withoutChameleon: Bool) {
            if withoutChameleon {
                action(firstParam.original, secondParam.original)
            } else {
                action(firstParam.correct, secondParam.correct)
            }
        }
    }
    
    /// 有三个入参的换肤方法
    struct Three<A, B, C>: CallableProtocol where A: AppearancedProtocol, B: AppearancedProtocol, C: AppearancedProtocol {
        public let identifier: AppearanceCallableIdentifier
        public let firstParam: A
        public let secondParam: B
        public let thirdParam: C
        public let action: (A.InputType, B.InputType, C.InputType) -> Void
        public var category: AppearanceCallableCategory
        public var isAppearanced: Bool {
            firstParam.isAppearanced ||
            secondParam.isAppearanced ||
            thirdParam.isAppearanced
        }
        
        public init(
            firstParam: A, secondParam: B, thirdParam: C,
            identifier: AppearanceCallableIdentifier,
            action: @escaping (A.InputType, B.InputType, C.InputType) -> Void,
            category: AppearanceCallableCategory = AppearanceDefaultCallableCategory
        ) {
            self.firstParam = firstParam
            self.secondParam = secondParam
            self.thirdParam = thirdParam
            self.identifier = identifier
            self.action = action
            self.category = category
        }
        
        public func execute(withoutChameleon: Bool) {
            if withoutChameleon {
                action(
                    firstParam.original,
                    secondParam.original,
                    thirdParam.original
                )
            } else {
                action(
                    firstParam.correct,
                    secondParam.correct,
                    thirdParam.correct
                )
            }
        }
    }
    
    /// 有四个入参的换肤方法
    struct Four<A, B, C, D>: CallableProtocol where A: AppearancedProtocol, B: AppearancedProtocol, C: AppearancedProtocol, D: AppearancedProtocol {
        public let identifier: AppearanceCallableIdentifier
        public let firstParam: A
        public let secondParam: B
        public let thirdParam: C
        public let fourthParam: D
        public let action: (A.InputType, B.InputType, C.InputType, D.InputType) -> Void
        public var category: AppearanceCallableCategory
        public var isAppearanced: Bool {
            firstParam.isAppearanced ||
            secondParam.isAppearanced ||
            thirdParam.isAppearanced ||
            fourthParam.isAppearanced
        }
        
        public init(
            firstParam: A, secondParam: B, thirdParam: C, fourthParam: D,
            identifier: AppearanceCallableIdentifier,
            action: @escaping (A.InputType, B.InputType, C.InputType, D.InputType) -> Void,
            category: AppearanceCallableCategory = AppearanceDefaultCallableCategory
        ) {
            self.firstParam = firstParam
            self.secondParam = secondParam
            self.thirdParam = thirdParam
            self.fourthParam = fourthParam
            self.identifier = identifier
            self.action = action
            self.category = category
        }
        
        public func execute(withoutChameleon: Bool) {
            if withoutChameleon {
                action(
                    firstParam.original,
                    secondParam.original,
                    thirdParam.original,
                    fourthParam.original
                )
            } else {
                action(
                    firstParam.correct,
                    secondParam.correct,
                    thirdParam.correct,
                    fourthParam.correct
                )
            }
        }
    }
    
    /// 有五个入参的换肤方法
    struct Five<A, B, C, D, E>: CallableProtocol where A: AppearancedProtocol, B: AppearancedProtocol, C: AppearancedProtocol, D: AppearancedProtocol, E: AppearancedProtocol {
        public let identifier: AppearanceCallableIdentifier
        public let firstParam: A
        public let secondParam: B
        public let thirdParam: C
        public let fourthParam: D
        public let fifthParam: E
        public let action: (A.InputType, B.InputType, C.InputType, D.InputType, E.InputType) -> Void
        public var category: AppearanceCallableCategory
        public var isAppearanced: Bool {
            firstParam.isAppearanced ||
            secondParam.isAppearanced ||
            thirdParam.isAppearanced ||
            fourthParam.isAppearanced ||
            fifthParam.isAppearanced
        }
        
        public init(
            firstParam: A, secondParam: B, thirdParam: C, fourthParam: D, fifthParam: E,
            identifier: AppearanceCallableIdentifier,
            action: @escaping (A.InputType, B.InputType, C.InputType, D.InputType, E.InputType) -> Void,
            category: AppearanceCallableCategory = AppearanceDefaultCallableCategory
        ) {
            self.firstParam = firstParam
            self.secondParam = secondParam
            self.thirdParam = thirdParam
            self.fourthParam = fourthParam
            self.fifthParam = fifthParam
            self.identifier = identifier
            self.action = action
            self.category = category
        }
        
        public func execute(withoutChameleon: Bool) {
            if withoutChameleon {
                action(
                    firstParam.original,
                    secondParam.original,
                    thirdParam.original,
                    fourthParam.original,
                    fifthParam.original
                )
            } else {            
                action(
                    firstParam.correct,
                    secondParam.correct,
                    thirdParam.correct,
                    fourthParam.correct,
                    fifthParam.correct
                )
            }
        }
    }
}
