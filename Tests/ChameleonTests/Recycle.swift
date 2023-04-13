//
//  Recycle.swift
//  
//
//  Created by Jo on 2023/4/13.
//

import XCTest
import Chameleon

#if os(iOS)
import UIKit


private class MyLabel: UILabel {
    var key: String = ""
    deinit {
        print("deinit \(key)")
    }
    
    override var description: String {
        return "\(key) deinit \(self)"
    }
}

private class MyView: UIView {
    var key: String = ""
    deinit {
        print("deinit \(key)")
    }
    
    override var description: String {
        return "\(key) deinit \(self)"
    }
}

final class Recycle: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        AppearanceManager.shared.changeThemeWith(themeInfo: ThemeInfo.theme0)
        
        func test1() {
            let label = MyLabel()
            label.app_textColor = ThemeInfos.Theme0.C004
            label.key = "appearnced Label1"
            
            let label2 = MyLabel()
            label2.key = "not appearanced label2"
        }
        
        func test2() {
            let view = MyView()
            view.app_backgroundColor = ThemeInfos.Theme0.C001
            view.key = "appearanced view1"
            
            let view2 = MyView()
            view2.key = "not appearanced view2"
        }
        
        let label3 = MyLabel()
        label3.app_textColor = ThemeInfos.Theme0.C004
        label3.key = "appearnced Label3"
        
        let view3 = MyView()
        view3.app_backgroundColor = ThemeInfos.Theme0.C001
        view3.key = "appearanced view3"
        
        test1()
        test2()
        
        AppearanceManager.shared.changeThemeWith(themeInfo: ThemeInfo.theme1)
        
        AppearanceManager.shared.changeThemeWith(themeInfo: ThemeInfo.theme2)
    }
}

#endif
