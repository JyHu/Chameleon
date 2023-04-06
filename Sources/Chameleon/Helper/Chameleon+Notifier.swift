//
//  File.swift
//  
//
//  Created by Jo on 2023/4/2.
//

import Foundation

public extension AppearanceManager {
    /// 换肤后发送的通知
    static let appearanceChanged = Notification.Name("com.auu.chameleon.notification.appearanceChanged")
}


private extension NSObject {
    struct _ThemeChangeObserverAssociation {
        static var associationKey: String = "com.auu.chameleon.themeChangeAssociationKey"
    }
    
    /// 用于记录是否注册过通知，每个对象只需要注册一次就行了
    var hadRegisterThemeChangeNotification: Bool {
        set {
            objc_setAssociatedObject(self, &_ThemeChangeObserverAssociation.associationKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
        get {
            objc_getAssociatedObject(self, &_ThemeChangeObserverAssociation.associationKey) as? Bool ?? false
        }
    }
}

internal extension AppearanceManager {
    /// 发送主题改变的通知，通知所有注册了主题监听的组件刷新
    func postThemeChangeNotification() {
        notificationCenter.post(name: AppearanceManager.appearanceChanged, object: nil)
    }
    
    /// 注册主题改变的通知
    /// - Parameters:
    ///   - observer: 要接收通知的对象
    ///   - action: 接收通知后的操作方法
    func registerAppearanceObserver(_ observer: NSObject, action: Selector) {
        if !observer.hadRegisterThemeChangeNotification {
            notificationCenter.addObserver(observer, selector: action, name: AppearanceManager.appearanceChanged, object: nil)
            observer.hadRegisterThemeChangeNotification = true
        }
    }
}
