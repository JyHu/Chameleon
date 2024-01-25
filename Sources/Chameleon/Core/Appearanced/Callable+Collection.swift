//
//  File.swift
//  
//
//  Created by Jo on 2023/4/11.
//

import Foundation

// MARK: - 实际的数组、字典换肤数据的持有及转换者

///
///
/// 转换协议，因为数组、字典的换肤支持逻辑不一样，需要区别去处理，
/// 但是又需要统一类型，所以用协议来抹平数据类型
///
///
private protocol __CollectionAppearanceConvert {
    associatedtype OutPut
    var correct: OutPut { get }
    var isAppearanced: Bool { get }
}

private extension Callable {
    /// 数组类换肤数据的持有、转换者
    struct __ArrayHolder<V>: __CollectionAppearanceConvert {
        /// 输出类型，即原范型T
        typealias OutPut = [V]
        
        /// 缓存的数组中的各换肤属性，用于后续的还原和查找对应的换肤属性值
        private let arrayAppearanced: [Appearanced<V>]
        
        var correct: [V] {
            arrayAppearanced.map { $0.correct }
        }
        
        var isAppearanced: Bool { arrayAppearanced.contains { $0.isAppearanced } }
        
        init(original: [V]) {
            self.arrayAppearanced = original.map { Appearanced($0) }
        }
    }
    
    /// 字典类型换肤数据的持有、转换者
    struct __DictionaryHolder<K, V>: __CollectionAppearanceConvert where K: Hashable {
        /// 输出类型，即原范型T
        typealias OutPut = [K: V]
        
        /// 缓存的数组中的各换肤属性，用于后续的还原和查找对应的换肤属性值
        private let dictionaryAppearanced: [K: Appearanced<V>]
        
        var correct: [K : V] {
            var result: [K: V] = [:]
            for (key, value) in dictionaryAppearanced {
                result[key] = value.correct
            }
            
            return result
        }
        
        var isAppearanced: Bool { dictionaryAppearanced.contains { $0.value.isAppearanced }}
        
        init(original: [K: V]) {
            var appearances: [K: Callable.Appearanced<V>] = [:]
            
            for (key, value) in original {
                appearances[key] = Callable.Appearanced(value)
            }
            
            self.dictionaryAppearanced = appearances
        }
    }
}

// MARK: - 集合属性换肤支持

public extension Callable {
    ///
    ///
    ///
    ///
    ///
    /// 支持数组、字典类型的换肤属性
    ///
    /// T：原始的入参类型，比如数组、字典类型
    /// E：根据入参类型不同会有不同的定义，可以见后面的4个extension
    ///
    ///
    ///
    struct Collection<T, E>: AppearancedProtocol {
        public typealias InputType = T
        
        public let original: T
        
        public let isAppearanced: Bool
        
        public var correct: T {
            (converter?.correct as? T) ?? original
        }
        
        private var converter: (any __CollectionAppearanceConvert)?
    }
}

// MARK: - 字典属性

///
///
/// 对于字典类型的集合来说，此处的E表示的是字典的Key，
/// 此处还额外的多了一个范型V，表示字典中的Value，
/// 在这里将入参范型T和入参范型V、E做下关联，即 T == [E: V]
///
///

extension Callable.Collection where E: Hashable {
    public init<V>(_ original: T) where T == [E: V] {
        self.original = original
        self.converter = Callable.__DictionaryHolder(original: original)
        self.isAppearanced = self.converter?.isAppearanced ?? false
    }
}

extension Callable.Collection where E: Hashable {
    public init<V>(_ original: T) where T == [E: V]? {
        self.original = original
        
        guard let original = original else {
            self.isAppearanced = false
            return
        }
        
        self.converter = Callable.__DictionaryHolder(original: original)
        self.isAppearanced = self.converter?.isAppearanced ?? false
    }
}

// MARK: - 数组属性

///
///
///
/// 对于数组来说，此处的E表示数组中的Element，即每个元素的类型
/// 在这里将入参范性T和E做下关联，即 T == [E]
///
///

extension Callable.Collection where T == [E] {
    public init(_ original: T) {
        self.original = original
        self.converter = Callable.__ArrayHolder(original: original)
        self.isAppearanced = self.converter?.isAppearanced ?? false
    }
}

extension Callable.Collection where T == [E]? {
    public init(_ original: T) {
        self.original = original
        
        guard let original = original else {
            self.isAppearanced = false
            return
        }
        
        self.converter = Callable.__ArrayHolder(original: original)
        self.isAppearanced = self.converter?.isAppearanced ?? false
    }
}
