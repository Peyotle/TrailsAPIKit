//
//  APIClientTests.swift
//  CycleNZ
//
//  Created by Oleg Chernyshenko on 6/07/16.
//  Copyright © 2016 Oleg Chernyshenko. All rights reserved.
//

import XCTest
@testable import TrailsAPIKit


class APIClientTests: XCTestCase {


//    var apiClient: APIClient!
//
//    override func setUp() {
//        super.setUp()
//        apiClient = APIClient()
//        apiClient.dataSource = FakeAPIDataSource()
//    }
//
//    override func tearDown() {
//        super.tearDown()
//        apiClient = nil
//    }
//
//    func testGetTrails() {
//        apiClient.getTrails { (trails, error) in
//            XCTAssertNotNil(trails, "Trails can't be lodaded")
//        }
//    }
//
//    func testPostTrail() {
//        let trail = FakeAPIDataSource.fakeTrail()
//        let asyncExpectation = expectation(description: "Post Trail Request")
//        var trailReturnedBycompletion: Trail?
//        apiClient.post(trail: trail) { (result, error) in
//            trailReturnedBycompletion = result
//            asyncExpectation.fulfill()
//        }
//
//        self.waitForExpectations(timeout: 0.1) { (error) in
//            XCTAssertNil(error)
//            XCTAssertNotNil(trailReturnedBycompletion)
//        }
//    }
//
//    func testDeleteTrail() {
//        let trail = FakeAPIDataSource.fakeTrail()
//        let asyncExpectation = expectation(description: "Post Trail Request")
//        var completionSuccess: Bool = false
//        apiClient.delete(trail: trail) { (success, error) in
//            completionSuccess = success
//            asyncExpectation.fulfill()
//        }
//
//        self.waitForExpectations(timeout: 0.1) { (error) in
//            XCTAssertNil(error)
//            XCTAssert(completionSuccess)
//        }
//    }
}
