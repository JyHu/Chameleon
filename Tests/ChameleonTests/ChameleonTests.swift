import XCTest

#if os(macOS)
import Cocoa
#else
import UIKit
#endif

@testable import Chameleon

final class ChameleonTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.

        #if os(macOS)
//        let text = NSText()
//        text.app_setTextColor(.red, range: NSMakeRange(0, 10))
//        text.app_setTextColor(.red, range: NSMakeRange(0, 20))
        
//        RunTimeKit.changeExchangeImplementations()
        
        AppearanceManager.exchangeImplementations()
        
        let color = NSColor.red
        print(color)
        let box = NSBox()
        box.fillColor = color
        box.fillColor = .blue
        box.fillColor = .yellow
        let _ = box.fillColor
        print(box.fillColor)
        
        #endif
    }
    
    func testRepeatSet() {
        #if os(macOS)
        AppearanceManager.shared.changeThemeWith(themeInfo: ThemeInfo.theme0)
        
        let label = NSTextField(labelWithString: "hello world")
        
        label.app_textColor = ThemeInfos.Theme0.C001
        
        AppearanceManager.shared.changeThemeWith(themeInfo: ThemeInfo.theme1)
        
        XCTAssertEqual(label.textColor, ThemeInfos.Theme1.C001)
        
        AppearanceManager.shared.changeThemeWith(themeInfo: ThemeInfo.theme2)
        
        XCTAssertEqual(label.textColor, ThemeInfos.Theme2.C001)
        
        label.app_textColor = ThemeInfos.Theme0.C002
        label.app_textColor = ThemeInfos.Theme0.C003
        
        AppearanceManager.shared.changeThemeWith(themeInfo: ThemeInfo.theme0)
        
        XCTAssertEqual(label.textColor, ThemeInfos.Theme0.C003)
        XCTAssertNotEqual(label.textColor, ThemeInfos.Theme0.C001)
        
        AppearanceManager.shared.changeThemeWith(themeInfo: ThemeInfo.theme1)
        
        XCTAssertEqual(label.textColor, ThemeInfos.Theme1.C003)
        XCTAssertNotEqual(label.textColor, ThemeInfos.Theme1.C001)
        
        AppearanceManager.shared.changeThemeWith(themeInfo: ThemeInfo.theme2)
        
        XCTAssertEqual(label.textColor, ThemeInfos.Theme2.C003)
        XCTAssertNotEqual(label.textColor, ThemeInfos.Theme2.C001)
        
        #endif
    }
    
    func testExecution() {
        let color1 = NSUIAppearanceColor.red
        let color2 = NSUIAppearanceColor.red
        
        testFunc1(color1)
        testFunc2(color2)
    }
    
    func testFunc1(_ color: NSUIAppearanceColor) {
        Cacher(param: color, callback: callback1(_:)).execute()
    }
    
    func testFunc2(_ color: NSUIAppearanceColor?) {
        Cacher(param: color, callback: callback2(_:)).execute()
    }
    
    func callback1(_ color: NSUIAppearanceColor) {
        print(String(describing: color))
    }
    
    func callback2(_ color: NSUIAppearanceColor?) {
        print(String(describing: color))
    }
}

struct Cacher<T> {
    let param: T
    let callback: ((T) -> Void)
    
    func execute() {
        callback(param)
    }
}
