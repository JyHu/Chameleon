//
//  ComplexTests.swift
//  
//
//  Created by Jo on 2023/4/17.
//

import XCTest
import Chameleon

final class ComplexTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        #if os(iOS)
        AppearanceManager.shared.changeThemeWith(themeInfo: ThemeInfo.theme0)
        
        let theme0 = ThemeInfos.Theme0.self
        
        let view = UIView()
        
        view.backgroundColor = theme0.C001
        
        XCTAssertEqual(view.backgroundColor, ThemeInfos.Theme0.C001)
        
        view.app_backgroundColor = theme0.C001
        
        XCTAssertEqual(view.backgroundColor, ThemeInfos.Theme0.C001)
        
        AppearanceManager.shared.changeThemeWith(themeInfo: ThemeInfo.theme1)
        
        XCTAssertEqual(view.backgroundColor, ThemeInfos.Theme1.C001)
        
        AppearanceManager.activeSwizzling()
        
        AppearanceManager.shared.changeThemeWith(themeInfo: ThemeInfo.theme2)
        
        XCTAssertEqual(view.backgroundColor, ThemeInfos.Theme2.C001)
        #endif
    }
}
