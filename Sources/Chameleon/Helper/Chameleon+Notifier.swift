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
        notificationCenter.addObserver(observer, selector: action, name: AppearanceManager.appearanceChanged, object: nil)
    }
}
