//
//  DictionaryTests.swift
//  
//
//  Created by Jo on 2023/4/6.
//

import XCTest
import Chameleon

final class DictionaryTests: XCTestCase {

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
        
        let id0 = "color/text/C001"
        let id1 = "color/background/C102"
        let id2 = "image/bg/tips"
        
        XCTAssertEqual((try? ThemeInfo.theme0.appearanceInfo(with: id0)) as! String, "F7ACBC")
        XCTAssertEqual((try? ThemeInfo.theme1.appearanceInfo(with: id1)) as! String, "8F4B2E 0.9")
        XCTAssertNil((try? ThemeInfo.theme2.appearanceInfo(with: id2)))
        XCTAssertNil((try? ThemeInfo.theme0.appearanceInfo(with: "color/textc000")))
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
