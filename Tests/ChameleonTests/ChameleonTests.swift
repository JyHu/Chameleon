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
        
        AppearanceImplementations.exchangeImplementations()
        
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
}
