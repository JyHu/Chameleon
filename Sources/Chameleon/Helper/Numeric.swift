//
//  File.swift
//  
//
//  Created by Jo on 2023/4/5.
//

import Foundation

internal protocol NumericAppearanceConvertProtocol {
    var app_int: Int { get }
    var app_int8: Int8 { get }
    var app_int16: Int16 { get }
    var app_int32: Int32 { get }
    var app_int64: Int64 { get }
    
    var app_uint: UInt { get }
    var app_uint8: UInt8 { get }
    var app_uint16: UInt16 { get }
    var app_uint32: UInt32 { get }
    var app_uint64: UInt64 { get }
    
    var app_double: Double { get }
    var app_cgfloat: CGFloat { get }
    
    var app_numberValue: NSNumber { get }
}

extension Int: NumericAppearanceConvertProtocol {
    var app_int: Int { return self }
    var app_int8: Int8 { return Int8(self) }
    var app_int16: Int16 { return Int16(self) }
    var app_int32: Int32 { return Int32(self) }
    var app_int64: Int64 { return Int64(self) }
    
    var app_uint: UInt { return UInt(self) }
    var app_uint8: UInt8 { return UInt8(self) }
    var app_uint16: UInt16 { return UInt16(self) }
    var app_uint32: UInt32 { return UInt32(self) }
    var app_uint64: UInt64 { return UInt64(self) }
    
    var app_double: Double { return Double(self) }
    var app_cgfloat: CGFloat { return CGFloat(self) }
    
    var app_numberValue: NSNumber { return NSNumber(value: self)}
}

extension Int8: NumericAppearanceConvertProtocol {
    var app_int: Int { return Int(self) }
    var app_int8: Int8 { return self }
    var app_int16: Int16 { return Int16(self) }
    var app_int32: Int32 { return Int32(self) }
    var app_int64: Int64 { return Int64(self) }
    
    var app_uint: UInt { return UInt(self) }
    var app_uint8: UInt8 { return UInt8(self) }
    var app_uint16: UInt16 { return UInt16(self) }
    var app_uint32: UInt32 { return UInt32(self) }
    var app_uint64: UInt64 { return UInt64(self) }
    
    var app_double: Double { return Double(self) }
    var app_cgfloat: CGFloat { return CGFloat(self) }
    
    var app_numberValue: NSNumber { return NSNumber(value: self)}
}

extension Int16: NumericAppearanceConvertProtocol {
    var app_int: Int { return Int(self) }
    var app_int8: Int8 { return Int8(self) }
    var app_int16: Int16 { return self }
    var app_int32: Int32 { return Int32(self) }
    var app_int64: Int64 { return Int64(self) }
    
    var app_uint: UInt { return UInt(self) }
    var app_uint8: UInt8 { return UInt8(self) }
    var app_uint16: UInt16 { return UInt16(self) }
    var app_uint32: UInt32 { return UInt32(self) }
    var app_uint64: UInt64 { return UInt64(self) }
    
    var app_double: Double { return Double(self) }
    var app_cgfloat: CGFloat { return CGFloat(self) }
    
    var app_numberValue: NSNumber { return NSNumber(value: self)}
}

extension Int32: NumericAppearanceConvertProtocol {
    var app_int: Int { return Int(self) }
    var app_int8: Int8 { return Int8(self) }
    var app_int16: Int16 { return Int16(self) }
    var app_int32: Int32 { return self }
    var app_int64: Int64 { return Int64(self) }
    
    var app_uint: UInt { return UInt(self) }
    var app_uint8: UInt8 { return UInt8(self) }
    var app_uint16: UInt16 { return UInt16(self) }
    var app_uint32: UInt32 { return UInt32(self) }
    var app_uint64: UInt64 { return UInt64(self) }
    
    var app_double: Double { return Double(self) }
    var app_cgfloat: CGFloat { return CGFloat(self) }
    
    var app_numberValue: NSNumber { return NSNumber(value: self)}
}

extension Int64: NumericAppearanceConvertProtocol {
    var app_int: Int { return Int(self) }
    var app_int8: Int8 { return Int8(self) }
    var app_int16: Int16 { return Int16(self) }
    var app_int32: Int32 { return Int32(self) }
    var app_int64: Int64 { return self }
    
    var app_uint: UInt { return UInt(self) }
    var app_uint8: UInt8 { return UInt8(self) }
    var app_uint16: UInt16 { return UInt16(self) }
    var app_uint32: UInt32 { return UInt32(self) }
    var app_uint64: UInt64 { return UInt64(self) }
    
    var app_double: Double { return Double(self) }
    var app_cgfloat: CGFloat { return CGFloat(self) }
    
    var app_numberValue: NSNumber { return NSNumber(value: self)}
}

extension UInt: NumericAppearanceConvertProtocol {
    var app_int: Int { return Int(self) }
    var app_int8: Int8 { return Int8(self) }
    var app_int16: Int16 { return Int16(self) }
    var app_int32: Int32 { return Int32(self) }
    var app_int64: Int64 { return Int64(self) }
    
    var app_uint: UInt { return self }
    var app_uint8: UInt8 { return UInt8(self) }
    var app_uint16: UInt16 { return UInt16(self) }
    var app_uint32: UInt32 { return UInt32(self) }
    var app_uint64: UInt64 { return UInt64(self) }
    
    var app_double: Double { return Double(self) }
    var app_cgfloat: CGFloat { return CGFloat(self) }
    
    var app_numberValue: NSNumber { return NSNumber(value: self)}
}

extension UInt8: NumericAppearanceConvertProtocol {
    var app_int: Int { return Int(self) }
    var app_int8: Int8 { return Int8(self) }
    var app_int16: Int16 { return Int16(self) }
    var app_int32: Int32 { return Int32(self) }
    var app_int64: Int64 { return Int64(self) }
    
    var app_uint: UInt { return UInt(self) }
    var app_uint8: UInt8 { return self }
    var app_uint16: UInt16 { return UInt16(self) }
    var app_uint32: UInt32 { return UInt32(self) }
    var app_uint64: UInt64 { return UInt64(self) }
    
    var app_double: Double { return Double(self) }
    var app_cgfloat: CGFloat { return CGFloat(self) }
    
    var app_numberValue: NSNumber { return NSNumber(value: self)}
}

extension uint16: NumericAppearanceConvertProtocol {
    var app_int: Int { return Int(self) }
    var app_int8: Int8 { return Int8(self) }
    var app_int16: Int16 { return Int16(self) }
    var app_int32: Int32 { return Int32(self) }
    var app_int64: Int64 { return Int64(self) }
    
    var app_uint: UInt { return UInt(self) }
    var app_uint8: UInt8 { return UInt8(self) }
    var app_uint16: UInt16 { return self }
    var app_uint32: UInt32 { return UInt32(self) }
    var app_uint64: UInt64 { return UInt64(self) }
    
    var app_double: Double { return Double(self) }
    var app_cgfloat: CGFloat { return CGFloat(self) }
    
    var app_numberValue: NSNumber { return NSNumber(value: self)}
}

extension UInt32: NumericAppearanceConvertProtocol {
    var app_int: Int { return Int(self) }
    var app_int8: Int8 { return Int8(self) }
    var app_int16: Int16 { return Int16(self) }
    var app_int32: Int32 { return Int32(self) }
    var app_int64: Int64 { return Int64(self) }
    
    var app_uint: UInt { return UInt(self) }
    var app_uint8: UInt8 { return UInt8(self) }
    var app_uint32: UInt32 { return self }
    var app_uint16: UInt16 { return UInt16(self) }
    var app_uint64: UInt64 { return UInt64(self) }
    
    var app_double: Double { return Double(self) }
    var app_cgfloat: CGFloat { return CGFloat(self) }
    
    var app_numberValue: NSNumber { return NSNumber(value: self)}
}

extension UInt64: NumericAppearanceConvertProtocol {
    var app_int: Int { return Int(self) }
    var app_int8: Int8 { return Int8(self) }
    var app_int16: Int16 { return Int16(self) }
    var app_int32: Int32 { return Int32(self) }
    var app_int64: Int64 { return Int64(self) }
    
    var app_uint: UInt { return UInt(self) }
    var app_uint8: UInt8 { return UInt8(self) }
    var app_uint16: UInt16 { return UInt16(self) }
    var app_uint32: UInt32 { return UInt32(self) }
    var app_uint64: UInt64 { return self }
    
    var app_double: Double { return Double(self) }
    var app_cgfloat: CGFloat { return CGFloat(self) }
    
    var app_numberValue: NSNumber { return NSNumber(value: self)}
}

extension Double: NumericAppearanceConvertProtocol {
    var app_int: Int { return Int(self) }
    var app_int8: Int8 { return Int8(self) }
    var app_int16: Int16 { return Int16(self) }
    var app_int32: Int32 { return Int32(self) }
    var app_int64: Int64 { return Int64(self) }
    
    var app_uint: UInt { return UInt(self) }
    var app_uint8: UInt8 { return UInt8(self) }
    var app_uint16: UInt16 { return UInt16(self) }
    var app_uint32: UInt32 { return UInt32(self) }
    var app_uint64: UInt64 { return UInt64(self) }
    
    var app_double: Double { return self }
    var app_cgfloat: CGFloat { return CGFloat(self) }
    
    var app_numberValue: NSNumber { return NSNumber(value: self)}
}

extension CGFloat: NumericAppearanceConvertProtocol {
    var app_int: Int { return Int(self) }
    var app_int8: Int8 { return Int8(self) }
    var app_int16: Int16 { return Int16(self) }
    var app_int32: Int32 { return Int32(self) }
    var app_int64: Int64 { return Int64(self) }
    
    var app_uint: UInt { return UInt(self) }
    var app_uint8: UInt8 { return UInt8(self) }
    var app_uint16: UInt16 { return UInt16(self) }
    var app_uint32: UInt32 { return UInt32(self) }
    var app_uint64: UInt64 { return UInt64(self) }
    
    var app_double: Double { return Double(self) }
    var app_cgfloat: CGFloat { return self }
    
    var app_numberValue: NSNumber { return NSNumber(value: self)}
}

extension NSNumber: NumericAppearanceConvertProtocol {
    var app_int: Int { return self.intValue }
    var app_int8: Int8 { return self.int8Value }
    var app_int16: Int16 { return self.int16Value }
    var app_int32: Int32 { return self.int32Value }
    var app_int64: Int64 { return self.int64Value }
    
    var app_uint: UInt { return self.uintValue }
    var app_uint8: UInt8 { return self.uint8Value }
    var app_uint16: UInt16 { return self.uint16Value }
    var app_uint32: UInt32 { return self.uint32Value }
    var app_uint64: UInt64 { return self.uint64Value }
    
    var app_double: Double { return self.doubleValue }
    var app_cgfloat: CGFloat { return self.doubleValue }
    
    var app_numberValue: NSNumber { return self }
}

extension String {
    var app_int: Int? { return Int(self) }
    var app_int8: Int8? { return Int8(self) }
    var app_int16: Int16? { return Int16(self) }
    var app_int32: Int32? { return Int32(self) }
    var app_int64: Int64? { return Int64(self) }
    
    var app_uint: UInt? { return UInt(self) }
    var app_uint8: UInt8? { return UInt8(self) }
    var app_uint16: UInt16? { return UInt16(self) }
    var app_uint32: UInt32? { return UInt32(self) }
    var app_uint64: UInt64? { return UInt64(self) }
    
    var app_double: Double? { return Double(self) }
    var app_cgfloat: CGFloat? {
        if let doubleVal = app_double { return CGFloat(doubleVal) }
        return nil
    }
    
    var app_numberValue: NSNumber? { return NSDecimalNumber(string: self) }
}

internal func matchedAppearancedNumValue<T>(from numValue: Any?, of type: Callable.NumType) -> T? {
    if let numValue = numValue as? T {
        return numValue
    }
    
    if T.self == Int.self {
        if let numVal = numValue as? String { return numVal.app_int as? T}
        return (numValue as? NumericAppearanceConvertProtocol)?.app_int as? T
    } else if T.self == Int8.self {
        if let numVal = numValue as? String { return numVal.app_int8 as? T}
        return (numValue as? NumericAppearanceConvertProtocol)?.app_int8 as? T
    } else if T.self == Int16.self {
        if let numVal = numValue as? String { return numVal.app_int16 as? T}
        return (numValue as? NumericAppearanceConvertProtocol)?.app_int16 as? T
    } else if T.self == Int32.self {
        if let numVal = numValue as? String { return numVal.app_int32 as? T}
        return (numValue as? NumericAppearanceConvertProtocol)?.app_int32 as? T
    } else if T.self == Int64.self {
        if let numVal = numValue as? String { return numVal.app_int64 as? T}
        return (numValue as? NumericAppearanceConvertProtocol)?.app_int64 as? T
    } else if T.self == UInt.self {
        if let numVal = numValue as? String { return numVal.app_uint as? T}
        return (numValue as? NumericAppearanceConvertProtocol)?.app_uint as? T
    } else if T.self == UInt8.self {
        if let numVal = numValue as? String { return numVal.app_uint8 as? T}
        return (numValue as? NumericAppearanceConvertProtocol)?.app_uint8 as? T
    } else if T.self == UInt16.self {
        if let numVal = numValue as? String { return numVal.app_uint16 as? T}
        return (numValue as? NumericAppearanceConvertProtocol)?.app_uint16 as? T
    } else if T.self == UInt32.self {
        if let numVal = numValue as? String { return numVal.app_uint32 as? T}
        return (numValue as? NumericAppearanceConvertProtocol)?.app_uint32 as? T
    } else if T.self == UInt64.self {
        if let numVal = numValue as? String { return numVal.app_uint64 as? T}
        return (numValue as? NumericAppearanceConvertProtocol)?.app_uint64 as? T
    } else if T.self == Double.self {
        if let numVal = numValue as? String { return numVal.app_double as? T}
        return (numValue as? NumericAppearanceConvertProtocol)?.app_double as? T
    } else if T.self == CGFloat.self {
        if let numVal = numValue as? String { return numVal.app_cgfloat as? T}
        return (numValue as? NumericAppearanceConvertProtocol)?.app_cgfloat as? T
    } else if T.self == NSNumber.self {
        if let numVal = numValue as? String { return numVal.app_numberValue as? T}
        return (numValue as? NumericAppearanceConvertProtocol)?.app_numberValue as? T
    }
    
    return nil
}
