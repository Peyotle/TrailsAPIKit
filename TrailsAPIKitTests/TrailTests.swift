//
//  TrailTest.swift
//  CycleNZ
//
//  Created by Oleg Chernyshenko on 30/06/16.
//  Copyright © 2016 Oleg Chernyshenko. All rights reserved.
//

import XCTest
@testable import CycleNZ

class TrailTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testTrailInitWithAllParameters() {
        let coordinates = FakeAPIDataSource.fakeCoordinates()
        let trail = Trail(name: "Trail",
                          coordinates: coordinates,
                          grade: .Easiest,
                          id: "id1")
        XCTAssertNotNil(trail)
    }


    func testTrailInitWithDefaultParameters() {
        let coordinates = FakeAPIDataSource.fakeCoordinates()
        let trail = Trail(name: "Trail",
                          coordinates: coordinates)
        XCTAssertNotNil(trail)
    }

    func testTrailToDictionary() {
        let coordinates = FakeAPIDataSource.fakeCoordinates()
        let trail = Trail(name: "Trail",
                          coordinates: coordinates,
                          grade: .Easiest,
                          id: "id1")
        let trailDictionary = trail.toDictionary()
        XCTAssertNotNil(trailDictionary)
    }

    func testTrailInitWithDictionary() {
        let trail = try? Trail(with: FakeAPIDataSource.fakeTrailDictionary())
        XCTAssertNotNil(trail)
    }

    func testTrailInitWithWrongCoordinatesDictionary() {
        var wrongDictionary = FakeAPIDataSource.fakeTrailDictionary()
        wrongDictionary["coordinates"] = ""
        let trail = try? Trail(with: wrongDictionary)
        XCTAssertNil(trail)
    }

    func testTrailInitWithWrongNameDictionary() {
        var wrongDictionary = FakeAPIDataSource.fakeTrailDictionary()
        wrongDictionary["name"] = ""
        let trail = try? Trail(with: wrongDictionary)
        XCTAssertNil(trail)
    }

    func testTrailInitWithWrongGradeDictionary() {
        var wrongDictionary = FakeAPIDataSource.fakeTrailDictionary()
        wrongDictionary["grade"] = ""
        let trail = try? Trail(with: wrongDictionary)
        XCTAssertNil(trail)
    }

    func testTrailInitWithWrongIdDictionary() {
        var wrongDictionary = FakeAPIDataSource.fakeTrailDictionary()
        wrongDictionary["_id"] = ""
        let trail = try? Trail(with: wrongDictionary)
        XCTAssertNil(trail)
    }
}


//{
//    "name": "Trail",
//    "grade": 1,
//    "_id": "id1",
//    "coordinates": [{
//    "lat": -36.843053,
//    "lng": 174.766465
//    }, {
//    "lat": -36.843053,
//    "lng": 174.766465
//    }]
//}
