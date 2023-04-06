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
    func execute()
}

/// 可执行换肤方法对象的默认分组
public let AppearanceDefaultCallableCategory = "DefaultCategory"

public struct Callable { }

public extension Callable {
    
    /// 只有一个入参的换肤方法
    struct One<A>: CallableProtocol {
        public let identifier: AppearanceCallableIdentifier
        public let firstParam: Appearanced<A>
        public let action: (A) -> Void
        public let category: AppearanceCallableCategory
        
        public init(
            firstParam: A,
            identifier: AppearanceCallableIdentifier,
            action: @escaping (A) -> Void,
            category: String = AppearanceDefaultCallableCategory
        ) {
            self.firstParam = Appearanced(original: firstParam)
            self.identifier = identifier
            self.action = action
            self.category = category
        }
        
        public init(
            firstParam: Appearanced<A>,
            identifier: AppearanceCallableIdentifier,
            action: @escaping (A) -> Void,
            category: String = AppearanceDefaultCallableCategory
        ) {
            self.firstParam = firstParam
            self.identifier = identifier
            self.action = action
            self.category = category
        }
        
        public func execute() {
            action(firstParam.correct)
        }
    }
    
    /// 有两个入参的换肤方法
    struct Two<A, B>: CallableProtocol {
        public let identifier: AppearanceCallableIdentifier
        public let firstParam: Appearanced<A>
        public let secondParam: Appearanced<B>
        public let action: (A, B) -> Void
        public let category: AppearanceCallableCategory
        
        public init(
            firstParam: A,
            secondParam: B,
            identifier: AppearanceCallableIdentifier,
            action: @escaping (A, B) -> Void,
            category: String = AppearanceDefaultCallableCategory
        ) {
            self.firstParam = Appearanced(original: firstParam)
            self.secondParam = Appearanced(original: secondParam)
            self.identifier = identifier
            self.action = action
            self.category = category
        }
        
        public init(
            firstParam: Appearanced<A>,
            secondParam: Appearanced<B>,
            identifier: AppearanceCallableIdentifier,
            action: @escaping (A, B) -> Void,
            category: String = AppearanceDefaultCallableCategory
        ) {
            self.firstParam = firstParam
            self.secondParam = secondParam
            self.identifier = identifier
            self.action = action
            self.category = category
        }
        
        public func execute() {
            action(firstParam.correct, secondParam.correct)
        }
    }
    
    /// 有三个入参的换肤方法
    struct Three<A, B, C>: CallableProtocol {
        public let identifier: AppearanceCallableIdentifier
        public let firstParam: Appearanced<A>
        public let secondParam: Appearanced<B>
        public let thirdParam: Appearanced<C>
        public let action: (A, B, C) -> Void
        public var category: AppearanceCallableCategory
        
        init(
            firstParam: A,
            secondParam: B,
            thirdParam: C,
            identifier: AppearanceCallableIdentifier,
            action: @escaping (A, B, C) -> Void,
            category: String = AppearanceDefaultCallableCategory
        ) {
            self.firstParam = Appearanced(original: firstParam)
            self.secondParam = Appearanced(original: secondParam)
            self.thirdParam = Appearanced(original: thirdParam)
            self.identifier = identifier
            self.action = action
            self.category = category
        }
        
        init(
            firstParam: Appearanced<A>,
            secondParam: Appearanced<B>,
            thirdParam: Appearanced<C>,
            identifier: AppearanceCallableIdentifier,
            action: @escaping (A, B, C) -> Void,
            category: String = AppearanceDefaultCallableCategory
        ) {
            self.firstParam = firstParam
            self.secondParam = secondParam
            self.thirdParam = thirdParam
            self.identifier = identifier
            self.action = action
            self.category = category
        }
        
        public func execute() {
            action(
                firstParam.correct,
                secondParam.correct,
                thirdParam.correct
            )
        }
    }
    
    /// 有四个入参的换肤方法
    struct Four<A, B, C, D>: CallableProtocol {
        public let identifier: AppearanceCallableIdentifier
        public let firstParam: Appearanced<A>
        public let secondParam: Appearanced<B>
        public let thirdParam: Appearanced<C>
        public let fourthParam: Appearanced<D>
        public let action: (A, B, C, D) -> Void
        public var category: AppearanceCallableCategory
        
        init(
            firstParam: A,
            secondParam: B,
            thirdParam: C,
            fourthParam: D,
            identifier: AppearanceCallableIdentifier,
            action: @escaping (A, B, C, D) -> Void,
            category: String = AppearanceDefaultCallableCategory
        ) {
            self.firstParam = Appearanced(original: firstParam)
            self.secondParam = Appearanced(original: secondParam)
            self.thirdParam = Appearanced(original: thirdParam)
            self.fourthParam = Appearanced(original: fourthParam)
            self.identifier = identifier
            self.action = action
            self.category = category
        }
        
        init(
            firstParam: Appearanced<A>,
            secondParam: Appearanced<B>,
            thirdParam: Appearanced<C>,
            fourthParam: Appearanced<D>,
            identifier: AppearanceCallableIdentifier,
            action: @escaping (A, B, C, D) -> Void,
            category: String = AppearanceDefaultCallableCategory
        ) {
            self.firstParam = firstParam
            self.secondParam = secondParam
            self.thirdParam = thirdParam
            self.fourthParam = fourthParam
            self.identifier = identifier
            self.action = action
            self.category = category
        }
        
        public func execute() {
            action(
                firstParam.correct,
                secondParam.correct,
                thirdParam.correct,
                fourthParam.correct
            )
        }
    }
    
    /// 有五个入参的换肤方法
    struct Five<A, B, C, D, E>: CallableProtocol {
        public let identifier: AppearanceCallableIdentifier
        public let firstParam: Appearanced<A>
        public let secondParam: Appearanced<B>
        public let thirdParam: Appearanced<C>
        public let fourthParam: Appearanced<D>
        public let fifthParam: Appearanced<E>
        public let action: (A, B, C, D, E) -> Void
        public var category: AppearanceCallableCategory
        
        init(
            firstParam: A, secondParam: B, thirdParam: C, fourthParam: D, fifthParam: E,
            identifier: AppearanceCallableIdentifier,
            action: @escaping (A, B, C, D, E) -> Void,
            category: String = AppearanceDefaultCallableCategory
        ) {
            self.firstParam = Appearanced(original: firstParam)
            self.secondParam = Appearanced(original: secondParam)
            self.thirdParam = Appearanced(original: thirdParam)
            self.fourthParam = Appearanced(original: fourthParam)
            self.fifthParam = Appearanced(original: fifthParam)
            self.identifier = identifier
            self.action = action
            self.category = category
        }
        
        init(
            firstParam: Appearanced<A>,
            secondParam: Appearanced<B>,
            thirdParam: Appearanced<C>,
            fourthParam: Appearanced<D>,
            fifthParam: Appearanced<E>,
            identifier: AppearanceCallableIdentifier,
            action: @escaping (A, B, C, D, E) -> Void,
            category: String = AppearanceDefaultCallableCategory
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
        
        public func execute() {
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
