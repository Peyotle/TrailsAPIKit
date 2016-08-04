//
//  NetworkAPIClientTests.swift
//  CycleNZ
//
//  Created by Oleg Chernyshenko on 9/07/16.
//  Copyright © 2016 Oleg Chernyshenko. All rights reserved.
//

import XCTest
@testable import TrailsAPIKit

// swiftlint:disable force_cast

class NetworkAPIDataSourceTests: XCTestCase {

    var networkClient: NetworkAPIDataSource!
    let authorizationString = "Basic T2xlZzpwYXM="
    override func setUp() {
        super.setUp()
        networkClient = NetworkAPIDataSource()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        networkClient = nil
        super.tearDown()
    }


    func testAuthorizationString() {
        let authString = networkClient.authorizationString(userName: "Oleg", password: "pas")
        print(authString)
        XCTAssertEqual(authString, authorizationString)
    }

    func testAuthorizedConfiguration() {
        let config = networkClient.authorizedConfiguration()
        if let headers = config.httpAdditionalHeaders {
            let authHeader = headers["Authorization"] as! String
            XCTAssertEqual(authHeader, authorizationString)
        } else {
            XCTFail("No Authorization header")
        }
    }

    func testRequestContentTypeIsJSON() {
        let request = networkClient.jsonRequest(with: "test")
        let requestValues = request.value(forHTTPHeaderField: "Content-Type")
        XCTAssertEqual(requestValues, "application/json")
    }

    func testSiteQueryForRegion() {
        let region = (1.0, 2.0, 3.0, 4.0)

        let query = networkClient.siteQuery(for: region)
        print(query)

    }



}
