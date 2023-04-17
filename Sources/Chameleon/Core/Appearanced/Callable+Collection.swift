//
//  File.swift
//  
//
//  Created by Jo on 2023/4/11.
//

import Foundation

private protocol __CollectionAppearanceConvert {
    associatedtype OutPut
    var correct: OutPut { get }
    var isAppearanced: Bool { get }
}

private extension Callable {
    struct __ArrayHolder<V>: __CollectionAppearanceConvert {
        typealias OutPut = [V]
        
        private let arrayAppearanced: [Appearanced<V>]
        
        var correct: [V] {
            arrayAppearanced.map { $0.correct }
        }
        
        var isAppearanced: Bool { arrayAppearanced.contains { $0.isAppearanced } }
        
        init(original: [V]) {
            self.arrayAppearanced = original.map { Appearanced($0) }
        }
    }
    
    struct __DictionaryHolder<K, V>: __CollectionAppearanceConvert where K: Hashable {
        typealias OutPut = [K: V]
        
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

public extension Callable {
    ///
    ///
    ///
    ///
    ///
    /// 支持数组、字典类型的换肤属性
    ///
    ///
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
