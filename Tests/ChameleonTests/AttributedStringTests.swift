//
//  DictionaryTests.swift
//
//
//  Created by Jo on 2023/4/6.
//

import XCTest
import Chameleon

final class AttributedStringTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
        let attributedString = NSMutableAttributedString(string: "Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.")
        attributedString.addAttributes([.foregroundColor: NSColor.red], range: NSMakeRange(0, 4))
        attributedString.addAttributes([.foregroundColor: NSColor.blue], range: NSMakeRange(8, 5))
        attributedString.addAttributes([.font: NSFont.systemFont(ofSize: 18)], range: NSMakeRange(2, 8))
        
        func enumerated() {
            attributedString.enumerateAttributes(in: NSMakeRange(0, attributedString.length)) { attributes, range, stop in
                print("---> \(range.location)->\(range.location + range.length): \(attributes.keys)")
            }
            attributedString.enumerateAttribute(.foregroundColor, in: NSMakeRange(0, attributedString.length)) { value, range, stop in
                print("===> \(range.location)->\(range.location + range.length): \(String(describing: value))")
            }
        }
        
        enumerated()
        
        print("\n\n\n")
        attributedString.addAttributes([.foregroundColor: NSColor.cyan], range: NSMakeRange(8, 5))
        
        enumerated()
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
