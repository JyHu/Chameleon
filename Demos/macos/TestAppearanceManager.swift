//
//  TestAppearanceManager.swift
//  macos
//
//  Created by Jo on 2023/4/10.
//

import Foundation
import Chameleon

class MyTheme {
    var identifier: String = UUID().uuidString
    var name: String = "My Theme"
    var folder: URL? = nil
    
    fileprivate var appearanceInfo: [String: Any]?
}

class TestAppearanceManager: NSObject {
    static var shared = TestAppearanceManager()
    
    private(set) var themes: [MyTheme] = []
    private var themesMap: [String: MyTheme] = [:]
    
    override init() {
        super.init()
        /// 这两个协议可用可不用，主要是为了开放更多的能力给使用者，这里仅作示例
        AppearanceManager.shared.delegate = self
        AppearanceManager.shared.customizedDelegate = self
        
        loadLocalThemes()
        downloadThemes()
    }
    
    func switchTheme(_ identifier: String) {
        guard let theme = themesMap[identifier] else { return }
        if theme.appearanceInfo == nil {
//            let themeInfo = ....
//            theme.appearanceInfo = ....
        }
        
        guard let themeInfo = theme.appearanceInfo else { return }
        AppearanceManager.shared.changeThemeWith(themeInfo: themeInfo)
    }
}

private extension TestAppearanceManager {
    func loadLocalThemes() {
        /// 加载本地的皮肤资源文件
        /// 然后缓存到themes中
    }
    
    func downloadThemes() {
        /// 下载云端的换肤资源
    }
    
    func transferToMap() {
        /// themes -> themesMap
        /// 方便查找
        for theme in themes {
            themesMap[theme.identifier] = theme
        }
    }
}

/// 自己管理换肤资源，需要向框架内提供
extension TestAppearanceManager: AppearanceManagerProtocol {
    func appearanceInfo(with identifier: Chameleon.AppearanceCallableIdentifier) throws -> Any? {
        return nil
    }
    
    var currentThemePath: String? {
        return nil
    }
}

/// 开放给使用者自己来处理颜色、图片的转换和查找
extension TestAppearanceManager: CustomizedAppearanceProtocol {
    func customizedAppearancedColor(of appearanceInfo: Any, identifier: Chameleon.AppearanceCallableIdentifier) -> Chameleon.CustomizedAppearanceResult<Chameleon.NSUIAppearanceColor> {
        return .result(.red, true)
    }
    
    func customizedAppearancedImage(of appearanceInfo: Any, identifier: Chameleon.AppearanceCallableIdentifier) -> Chameleon.CustomizedAppearanceResult<Chameleon.NSUIAppearanceImage> {
        return .ignored
    }
    
    
}
