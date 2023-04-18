//
//  File.swift
//  
//
//  Created by Jo on 2023/4/6.
//

#if canImport(Cocoa)
import Cocoa
#elseif canImport(UIKit)
import UIKit
#endif

/// 是否使用了swizzling
public var __USING_APPEARANCED_SWIZZLING__: Bool { AppearanceManager.shared.usingSwizzling }

/// 换肤资源管理协议，用于将资源管理放到外部
public protocol AppearanceManagerProtocol: NSObjectProtocol {
    
    /// 根据给定的换肤标识符获取对应换肤资源源数据
    /// - Parameter identifier: 换肤标识符
    /// - Returns: 资源源数据
    func appearanceInfo(with identifier: AppearanceCallableIdentifier) throws -> Any?
    
    /// 当前主题的的目录，用于加载本地的图片资源
    var currentThemePath: String? { get }
}

/// 图片、颜色转换后的结果
public enum CustomizedAppearanceResult<T> {
    /// 使用者成功转换
    ///  - value: 转换后的结果，图片或者颜色
    ///  - shouldCache: 是否需要缓存，如果需要的话，会把转换后的数据缓存起来，
    ///     下次有相同的key来获取数据，就不需要转换，直接读取缓存即可
    case result(_ value: T, _ shouldCache: Bool)
    
    /// 使用者不管，直接跳过，由框架内部自己转换
    case ignored
}

/// 由换肤框架开放出去的，由使用者自定义转换颜色、图片的协议方法
/// 如果使用方实现了这两个协议方法，那么会优先调用这两个方法来生成对应的换肤的颜色、图片，
/// 如果使用方返回了空数据，那么会在框架内自己处理
public protocol CustomizedAppearanceProtocol: NSObjectProtocol {
    func customizedAppearancedColor(of appearanceInfo: Any, identifier: AppearanceCallableIdentifier) -> CustomizedAppearanceResult<NSUIAppearanceColor>
    func customizedAppearancedImage(of appearanceInfo: Any, identifier: AppearanceCallableIdentifier) -> CustomizedAppearanceResult<NSUIAppearanceImage>
}

/// 提供默认实现，将协议方法变为可选方法
public extension CustomizedAppearanceProtocol {
    func customizedAppearancedColor(of appearanceInfo: Any, identifier: AppearanceCallableIdentifier) -> CustomizedAppearanceResult<NSUIAppearanceColor> {
        guard let colorInfo = appearanceInfo as? String else { return .ignored }
        guard let color = NSUIAppearanceColor.colorWith(appearancedValue: colorInfo) else { return .ignored }
        return .result(color, true)
    }
    
    func customizedAppearancedImage(of appearanceInfo: Any, identifier: AppearanceCallableIdentifier) -> CustomizedAppearanceResult<NSUIAppearanceImage> {
        guard let image = try? NSUIAppearanceImage.imageWith(appearancedValue: appearanceInfo) else { return .ignored }
        return .result(image, true)
    }
}

/// 换肤框架的资源管理类，用于资源、状态、数据的管理
public class AppearanceManager: NSObject {
    /// 获取单例
    public static var shared = AppearanceManager()
    
    /// 缓存的换肤资源的原始数据
    private var appearanceInfos: [String: Any] = [:]
    
    /// 缓存通过换肤资源id转换后的数据
    /// 比如通过色号转换成的颜色、图片等
    private var cachedLegalObjects: [AppearanceCallableIdentifier: Any] = [:]
    
    /// 当前换肤资源所在的目录，用于查找通过文件方式读取到的资源
    private var resourcesPath: String?
    
    /// 留给外部管理皮肤属性的代理，如果设置了这个属性，这里管理类将不会再管理任何属性信息，都交给外部处理
    public weak var delegate: AppearanceManagerProtocol?
    
    /// 由换肤框架开放出去的，由使用者自定义转换颜色、图片、其他换肤属性的协议方法
    public weak var customizedDelegate: CustomizedAppearanceProtocol?
    
    /// 换肤相关的通知中心
    public let notificationCenter = NotificationCenter()
    
    /// 是否使用了swizzling
    fileprivate var usingSwizzling: Bool = false
    
    /// 更换主题
    /// - Parameters:
    ///   - themeInfo: 主题资源的目录
    ///   - sourcePath: 主题的详细信息
    public func changeThemeWith(themeInfo: [String: Any], sourcePath: String? = nil) {
        resourcesPath = sourcePath
        appearanceInfos = themeInfo
        performThemeChang()
    }
    
    /// 如果设置了appearanceDelegate属性，那么需要调用这个方法来触发换肤
    public func performThemeChang() {
        /// 换肤后的第一件事是先清空上次皮肤中的所有转换后的缓存数据
        cachedLegalObjects.removeAll()
        
        /// 发送通知给所有订阅者
        postThemeChangeNotification()
    }
    
    /// 启用swizzling
    public static func activeSwizzling() {
        /// 如果做了swizzling，就跳过不做了。
        if shared.usingSwizzling { return }
        shared.usingSwizzling = true
        exchangeImplementations()
    }
}

internal extension AppearanceManager {
    /// 通过颜色的资源id获取到对应的有效的颜色资源
    /// - Parameter identifier: 资源id
    /// - Returns: 颜色对象
    func color(with identifier: AppearanceCallableIdentifier) -> NSUIAppearanceColor? {
        
        /// 如果有缓存的颜色对象，直接返回
        if let color = cachedLegalObjects[identifier] as? NSUIAppearanceColor {
            return color
        }
        
        guard let colorInfo = try? appearanceInfo(with: identifier) else { return nil }
        
        if let colorRes = customizedDelegate?.customizedAppearancedColor(of: colorInfo, identifier: identifier) {
            switch colorRes {
            case .result(let color, let shouldCache):
                if shouldCache {
                    cachedLegalObjects[identifier] = color
                    return color
                }
            case .ignored: break
            }
        }
        
        guard let colorInfo = colorInfo as? String else { return nil }
        
        if let color = NSUIAppearanceColor.colorWith(appearancedValue: colorInfo) {
            cachedLegalObjects[identifier] = color
            return color
        }
        
        return nil
    }
    
    /// 通过图片的资源id获取到对应的有效的图片资源
    /// - Parameter identifier: 资源id
    /// - Returns: 图片对象
    func image(with identifier: AppearanceCallableIdentifier) -> NSUIAppearanceImage? {
        
        /// 如果有缓存的转换后的图片资源，就直接返回
        if let image = cachedLegalObjects[identifier] as? NSUIAppearanceImage {
            return image
        }
        
        guard let imageInfo = try? appearanceInfo(with: identifier) else {
            return nil
        }
        
        if let imageRes = customizedDelegate?.customizedAppearancedImage(of: imageInfo, identifier: identifier) {
            switch imageRes {
            case .result(let image, let shouldCache):
                if shouldCache {
                    cachedLegalObjects[identifier] = image
                }
                return image
            case .ignored: break
            }
        }
        
        if let image = try? NSUIAppearanceImage.imageWith(appearancedValue: imageInfo) {
            cachedLegalObjects[identifier] = image
            return image
        }
        
        return nil
    }
}

extension AppearanceManager: AppearanceManagerProtocol {
    public var currentThemePath: String? {
        if let delegate = delegate {
            return delegate.currentThemePath
        }
        
        return resourcesPath
    }
    
    public func appearanceInfo(with identifier: AppearanceCallableIdentifier) throws -> Any? {
        if let delegate = delegate {
            return try delegate.appearanceInfo(with: identifier)
        }
        
        return try appearanceInfos.appearanceInfo(with: identifier)
    }
}
