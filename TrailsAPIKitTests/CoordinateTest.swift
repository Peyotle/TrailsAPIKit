//
//  CoordinateTest.swift
//  CycleNZ
//
//  Created by Oleg Chernyshenko on 30/06/16.
//  Copyright © 2016 Oleg Chernyshenko. All rights reserved.
//

import XCTest
@testable import CycleNZ

class CoordinateTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here.
    }

    override func tearDown() {
        // Put teardown code here.
        super.tearDown()
    }

    func testCoordinateInitWithLatitudeAndLongitude() {
        let coordinate = Coordinate(latitude: 1.0, longitude: 1.0)
        XCTAssertNotNil(coordinate)
    }

    func testCoordinateInitWithDictionary() {
        let coords = [1.0001, 2.0002]
        let coordinate = Coordinate(with: coords)
        XCTAssertNotNil(coordinate)
    }

    func testCoordinateInitWithWrongLength() {
        let coords = [1.0001]
        let coordinate = Coordinate(with: coords)
        XCTAssertNil(coordinate)
    }

    func testCoordinateToArray() {
        let coordinate = Coordinate(latitude: 1.0, longitude: 1.0)
        let coordinateArray = coordinate.toArray()
        XCTAssertNotNil(coordinateArray)
    }

    func testCoordinateToArrayLatitude() {
        let latitude = 1.0001
        let coordinate = Coordinate(latitude: latitude, longitude: 1.0)
        let coordinateArray = coordinate.toArray()
        let coordinateLat = coordinateArray[0]

        XCTAssertEqual(coordinateLat, latitude)
    }

    func testCoordinateToArrayLongitude() {
        let longitude = 2.0001
        let coordinate = Coordinate(latitude: 1.001, longitude: longitude)
        let coordinateArray = coordinate.toArray()
        let coordinateLng = coordinateArray[1]

        XCTAssertEqual(coordinateLng, longitude)
    }

    func testCoordinateArrayLength() {
        let coordinate = Coordinate(latitude: 1.0, longitude: 1.0)
        let coordinateArray = coordinate.toArray()

        XCTAssertEqual(coordinateArray.count, 2)
    }
}
