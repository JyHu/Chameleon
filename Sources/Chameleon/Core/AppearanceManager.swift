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

/// 换肤资源管理协议，用于将资源管理放到外部
public protocol AppearanceManagerProtocol: NSObjectProtocol {
    
    /// 根据给定的换肤标识符获取对应换肤资源源数据
    /// - Parameter identifier: 换肤标识符
    /// - Returns: 资源源数据
    func appearanceInfo(with identifier: AppearanceCallableIdentifier) throws -> Any?
    
    /// 当前主题的的目录，用于加载本地的图片资源
    var currentThemePath: String? { get }
}

public class AppearanceManager: NSObject {
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
    
    /// 换肤相关的通知中心
    public let notificationCenter = NotificationCenter()
    
    /// 是否使用了swizzing
    internal private(set) var usingSwizzing: Bool = false
    
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
        cachedLegalObjects.removeAll()
        postThemeChangeNotification()
    }
}

internal extension AppearanceManager {
    /// 启用swizzing
    func useSwizzing() {
        self.usingSwizzing = true
    }
    
    /// 通过颜色的资源id获取到对应的有效的颜色资源
    /// - Parameter identifier: 资源id
    /// - Returns: 颜色对象
    func color(with identifier: AppearanceCallableIdentifier) -> NSUIAppearanceColor? {
        if let color = cachedLegalObjects[identifier] as? NSUIAppearanceColor {
            return color
        }
        
        guard let colorInfo = try? appearanceInfo(with: identifier) as? String else { return nil }
        
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
        if let image = cachedLegalObjects[identifier] as? NSUIAppearanceImage {
            return image
        }
        
        guard let imageInfo = try? appearanceInfo(with: identifier) else {
            return nil
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
        return resourcesPath
    }
    
    public func appearanceInfo(with identifier: AppearanceCallableIdentifier) throws -> Any? {
        return try appearanceInfos.appearanceInfo(with: identifier)
    }
}

