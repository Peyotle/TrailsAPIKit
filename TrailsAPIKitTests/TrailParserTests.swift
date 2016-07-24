//
//  TrailParserTests.swift
//  CycleNZ
//
//  Created by Oleg Chernyshenko on 14/07/16.
//  Copyright © 2016 Oleg Chernyshenko. All rights reserved.
//

import XCTest
@testable import CycleNZ

class TrailParserTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testParseTrail() {
        guard let trailData = try? JSONSerialization.data(withJSONObject: FakeAPIDataSource.fakeTrailDictionary(), options: []) else {
            XCTFail("Trail data creation error")
            return
        }

        TrailParser.parseTrail(from: trailData) { (result, error) in
            if error != nil {
                XCTFail("Trail Parsing Error")
            }
            XCTAssertNotNil(result)
        }
    }
}
