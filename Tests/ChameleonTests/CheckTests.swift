//
//  CheckTests.swift
//  
//
//  Created by Jo on 2024/1/26.
//

import XCTest
@testable import Chameleon

final class CheckTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let d1 = [
            "a": [
                "b": [
                    "k": 1,
                    "d": 2
                ],
                "e": [
                    "f": 3,
                    "g": 4
                ],
                "h": 5,
                "i": 6
            ]
        ]
        
        let d2 = [
            "a": [
                "b": [
                    "k": 7,
                    "d": 8
                ],
                "e": [
                    "f": 9,
                    "g": 10
                ],
                "h": 11,
                "i": 12
            ]
        ]
        
        let d3 = [
            "a": [
                "b": [
                    "c": 13,
                    "d": 14
                ],
                "e": [
                    "f": 15,
                    "g": 16
                ],
                "h": 17,
                "i": 18
            ]
        ]
        
        let d4 = [
            "a": [
                "b": [
                    "c": 19,
                    "d": 20
                ],
                "e": [
                    "l": 21,
                    "g": 22
                ],
                "h": 23,
                "i": ["m": 44]
            ]
        ]
        
        let result = checkAppearanceInfos([
            CheckableAppearanceInfo(identifier: "d1", appearanceInfos: d1),
            CheckableAppearanceInfo(identifier: "d2", appearanceInfos: d2),
            CheckableAppearanceInfo(identifier: "d3", appearanceInfos: d3),
            CheckableAppearanceInfo(identifier: "d4", appearanceInfos: d4)
        ])
        
        print(result.map { "\($0)" }.joined(separator: "\n"))
        
        XCTAssertTrue(result.count > 0)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
