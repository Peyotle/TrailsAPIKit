//
//  PlaceTests.swift
//  CycleNZ
//
//  Created by Oleg Chernyshenko on 13/07/16.
//  Copyright © 2016 Oleg Chernyshenko. All rights reserved.
//

import XCTest
@testable import CycleNZ

class PlaceTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here.
    }

    override func tearDown() {
        // Put teardown code here.
        super.tearDown()
    }

    func testPlaceInit() {
        let coordinate = fakeCoordinate()

        let place = Place(name: "Test", coordinate: coordinate)
        XCTAssertNotNil(place)
    }

    func testPlaceToDictionary() {
        let coordinate = fakeCoordinate()
        let place = Place(name: "Place",
                          coordinate: coordinate,
                          type: .Danger,
                          id: "id1")
        let placeDictionary = place.toDictionary()
        XCTAssertNotNil(placeDictionary)
    }

    func testPlaceInitWithDictionary() {
        let place = try? Place(with: fakePlaceDictionary())
        XCTAssertNotNil(place)
    }

    func testPlaceInitWithWrongCoordinatesDictionary() {
        var wrongDictionary = fakePlaceDictionary()
        wrongDictionary["coordinate"] = ""
        let place = try? Place(with: wrongDictionary)
        XCTAssertNil(place)
    }

    func testPlaceInitWithWrongNameDictionary() {
        var wrongDictionary = fakePlaceDictionary()
        wrongDictionary["name"] = ""
        let place = try? Place(with: wrongDictionary)
        XCTAssertNil(place)
    }

    func testPlaceInitWithWrongGradeDictionary() {
        var wrongDictionary = fakePlaceDictionary()
        wrongDictionary["type"] = ""
        let place = try? Place(with: wrongDictionary)
        XCTAssertNil(place)
    }

    func testPlaceInitWithWrongIdDictionary() {
        var wrongDictionary = fakePlaceDictionary()
        wrongDictionary["_id"] = ""
        let place = try? Place(with: wrongDictionary)
        XCTAssertNil(place)
    }


    func fakeCoordinate() -> Coordinate {
        return Coordinate(latitude: -36.843053, longitude: 174.766465)
    }

    func fakePlaceDictionary() -> Dictionary<String, AnyObject> {
        let coordinate = [-36.843053, 174.766465]

        return [
            "name":"Place",
            "coordinate":coordinate,
            "type":1,
            "_id":"id1"
        ]
    }
}
