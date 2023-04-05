//
//  File.swift
//  
//
//  Created by Jo on 2023/4/3.
//

import Foundation

public protocol CustomizedAppearanceParamProtocol {
    
}

/// 换肤方法的执行对象
public protocol CallableProtocol {
    
    /// 当前执行对象的分类，可选值
    var category: AppearanceCallableCategory { get }
    
    /// 当前执行对象的唯一标识符，用于保证缓存执行对象只会存在一份
    var identifier: AppearanceCallableIdentifier { get }
    
    /// 在执行换肤的时候由框架内统一调用的方法，用于通知所有需要换肤的组件执行换肤的操作
    func execute()
}

public extension CallableProtocol {
    
    /// 将该协议方法处理成可选型
    var category: AppearanceCallableCategory {
        return "DefaultCategory"
    }
}


public struct Callable { }

public extension Callable {
    /// 只有一个入参的换肤方法
    struct One<A>: CallableProtocol {
        public let identifier: AppearanceCallableIdentifier
        /// 换肤方法的第一个参数
        public let firstParam: Appearanced<A>
        /// 换肤时执行的方法
        public let action: (Param<A>) -> Void
                
        /// 初始化方法
        /// - Parameters:
        ///   - firstParam: 换肤方法的第一个参数
        ///   - identifier: 唯一标识符
        ///   - action: 换肤时执行的方法
        init(
            firstParam: Param<A>,
            identifier: AppearanceCallableIdentifier,
            action: @escaping (Param<A>) -> Void
        ) {
            self.firstParam = Appearanced(original: firstParam)
            self.identifier = identifier
            self.action = action
        }
        
        public func execute() {
            action(firstParam.correct)
        }
    }
    
    /// 有两个入参的换肤方法
    struct Two<A, B>: CallableProtocol {
        public let identifier: AppearanceCallableIdentifier
        /// 换肤方法的第一个参数
        public let firstParam: Appearanced<A>
        /// 换肤方法的第二个参数
        public let secondParam: Appearanced<B>
        /// 换肤时执行的方法
        public let action: (Param<A>, Param<B>) -> Void
        
        /// 初始化方法
        /// - Parameters:
        ///   - firstParam: 换肤方法的第一个参数
        ///   - secondParam: 换肤方法的第二个参数
        ///   - identifier: 唯一标识符
        ///   - action: 换肤时执行的方法
        init(
            firstParam: Param<A>,
            secondParam: Param<B>,
            identifier: AppearanceCallableIdentifier,
            action: @escaping (Param<A>, Param<B>) -> Void
        ) {
            self.firstParam = Appearanced(original: firstParam)
            self.secondParam = Appearanced(original: secondParam)
            self.identifier = identifier
            self.action = action
        }
        
        public func execute() {
            action(firstParam.correct, secondParam.correct)
        }
    }
    
    /// 有三个入参的换肤方法
    struct Three<A, B, C>: CallableProtocol {
        public let identifier: AppearanceCallableIdentifier
        /// 换肤方法的第一个参数
        public let firstParam: Appearanced<A>
        /// 换肤方法的第二个参数
        public let secondParam: Appearanced<B>
        /// 换肤方法的第三个参数
        public let thirdParam: Appearanced<C>
        /// 换肤时执行的方法
        public let action: (Param<A>, Param<B>, Param<C>) -> Void
        
        /// 初始化方法
        /// - Parameters:
        ///   - firstParam: 换肤方法的第一个参数
        ///   - secondParam: 换肤方法的第二个参数
        ///   - thirdParam: 换肤方法的第三个参数
        ///   - identifier: 唯一标识符
        ///   - action: 换肤时执行的方法
        init(
            firstParam: Param<A>,
            secondParam: Param<B>,
            thirdParam: Param<C>,
            identifier: AppearanceCallableIdentifier,
            action: @escaping (Param<A>, Param<B>, Param<C>) -> Void
        ) {
            self.firstParam = Appearanced(original: firstParam)
            self.secondParam = Appearanced(original: secondParam)
            self.thirdParam = Appearanced(original: thirdParam)
            self.identifier = identifier
            self.action = action
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
        /// 换肤方法的第一个参数
        public let firstParam: Appearanced<A>
        /// 换肤方法的第二个参数
        public let secondParam: Appearanced<B>
        /// 换肤方法的第三个参数
        public let thirdParam: Appearanced<C>
        /// 换肤方法的第四个参数
        public let fourthParam: Appearanced<D>
        /// 换肤时执行的方法
        public let action: (Param<A>, Param<B>, Param<C>, Param<D>) -> Void
        
        /// 初始化方法
        /// - Parameters:
        ///   - firstParam: 换肤方法的第一个参数
        ///   - secondParam: 换肤方法的第二个参数
        ///   - thirdParam: 换肤方法的第三个参数
        ///   - fourthParam: 换肤方法的第四个参数
        ///   - identifier: 唯一标识符
        ///   - action: 换肤时执行的方法
        init(
            firstParam: Param<A>,
            secondParam: Param<B>,
            thirdParam: Param<C>,
            fourthParam: Param<D>,
            identifier: AppearanceCallableIdentifier,
            action: @escaping (Param<A>, Param<B>, Param<C>, Param<D>) -> Void
        ) {
            self.firstParam = Appearanced(original: firstParam)
            self.secondParam = Appearanced(original: secondParam)
            self.thirdParam = Appearanced(original: thirdParam)
            self.fourthParam = Appearanced(original: fourthParam)
            self.identifier = identifier
            self.action = action
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
        /// 换肤方法的第一个参数
        public let firstParam: Appearanced<A>
        /// 换肤方法的第二个参数
        public let secondParam: Appearanced<B>
        /// 换肤方法的第三个参数
        public let thirdParam: Appearanced<C>
        /// 换肤方法的第四个参数
        public let fourthParam: Appearanced<D>
        /// 换肤方法的第五个参数
        public let fifthParam: Appearanced<E>
        /// 换肤时执行的方法
        public let action: (Param<A>, Param<B>, Param<C>, Param<D>, Param<E>) -> Void
        
        /// 初始化方法
        /// - Parameters:
        ///   - firstParam: 换肤方法的第一个参数
        ///   - secondParam: 换肤方法的第二个参数
        ///   - thirdParam: 换肤方法的第三个参数
        ///   - fourthParam: 换肤方法的第四个参数
        ///   - fifthParam: 换肤方法的第五个参数
        ///   - identifier: 唯一标识符
        ///   - action: 换肤时执行的方法
        init(
            firstParam: Param<A>,
            secondParam: Param<B>,
            thirdParam: Param<C>,
            fourthParam: Param<D>,
            fifthParam: Param<E>,
            identifier: AppearanceCallableIdentifier,
            action: @escaping (Param<A>, Param<B>, Param<C>, Param<D>, Param<E>) -> Void
        ) {
            self.firstParam = Appearanced(original: firstParam)
            self.secondParam = Appearanced(original: secondParam)
            self.thirdParam = Appearanced(original: thirdParam)
            self.fourthParam = Appearanced(original: fourthParam)
            self.fifthParam = Appearanced(original: fifthParam)
            self.identifier = identifier
            self.action = action
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
    
    /// 有六个入参的换肤方法
    struct Six<A, B, C, D, E, F>: CallableProtocol {
        public let identifier: AppearanceCallableIdentifier
        /// 换肤方法的第一个参数
        public let firstParam: Appearanced<A>
        /// 换肤方法的第二个参数
        public let secondParam: Appearanced<B>
        /// 换肤方法的第三个参数
        public let thirdParam: Appearanced<C>
        /// 换肤方法的第四个参数
        public let fourthParam: Appearanced<D>
        /// 换肤方法的第五个参数
        public let fifthParam: Appearanced<E>
        /// 换肤方法的第六个参数
        public let sixthParam: Appearanced<F>
        /// 换肤时执行的方法
        public let action: (Param<A>, Param<B>, Param<C>, Param<D>, Param<E>, Param<F>) -> Void
        
        
        /// 初始化方法
        /// - Parameters:
        ///   - firstParam: 换肤方法的第一个参数
        ///   - secondParam: 换肤方法的第二个参数
        ///   - thirdParam: 换肤方法的第三个参数
        ///   - fourthParam: 换肤方法的第四个参数
        ///   - fifthParam: 换肤方法的第五个参数
        ///   - sixthParam: 换肤方法的第六个参数
        ///   - identifier: 唯一标识符
        ///   - action: 换肤时执行的方法
        init(
            firstParam: Param<A>,
            secondParam: Param<B>,
            thirdParam: Param<C>,
            fourthParam: Param<D>,
            fifthParam: Param<E>,
            sixthParam: Param<F>,
            identifier: AppearanceCallableIdentifier,
            action: @escaping (Param<A>, Param<B>, Param<C>, Param<D>, Param<E>, Param<F>) -> Void
        ) {
            self.firstParam = Appearanced(original: firstParam)
            self.secondParam = Appearanced(original: secondParam)
            self.thirdParam = Appearanced(original: thirdParam)
            self.fourthParam = Appearanced(original: fourthParam)
            self.fifthParam = Appearanced(original: fifthParam)
            self.sixthParam = Appearanced(original: sixthParam)
            self.identifier = identifier
            self.action = action
        }
        
        public func execute() {
            action(
                firstParam.correct,
                secondParam.correct,
                thirdParam.correct,
                fourthParam.correct,
                fifthParam.correct,
                sixthParam.correct
            )
        }
    }
}
