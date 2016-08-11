//
//  FakeAPIDataSource.swift
//  CycleNZ
//
//  Created by Oleg Chernyshenko on 13/07/16.
//  Copyright © 2016 Oleg Chernyshenko. All rights reserved.
//

import UIKit

class FakeAPIDataSource: APIDataSource {

    func getTrails(completion: (Result<Data, Error>) -> Void) {
        print("^getTrails")
        let arrayWithDict = [FakeAPIDataSource.fakeTrailDictionary()]
        do{
            let data = try JSONSerialization.data(withJSONObject: arrayWithDict, options: [])
            completion(.success(data))
        } catch {
            completion(.failure(error))
        }
    }

    func deleteTrail(with id: String, completion: (Result<Bool, Error>) -> Void) {
        completion(.success(true))
    }

    func postTrail(data: Data, completion: (Result<Data, Error>) -> Void) {
        do {
            let trailDict = FakeAPIDataSource.fakeTrailDictionary()
            let data = try JSONSerialization.data(withJSONObject: trailDict,
                                                  options: [])
            completion(.success(data))
        } catch {
            completion(.failure(error))
        }
    }
    
    public func getSites(completion: (Result<Data, Error>) -> Void) {

    }

    public func getSites(for region: (x0: Double, x1: Double, y0: Double, y1: Double), completion: (Result<Data, Error>) -> Void) {

    }

    public func postSite(data: Data, completion: (Result<Data, Error>) -> Void) {

    }
    
    class func fakeTrailDictionary() -> Dictionary<String, AnyObject> {
        let coordinates = [[-36.843053, 174.766465],
                             [-36.84423, 174.771012],
                             [-36.8452, 174.770473],
                             [-36.844233, 174.766888]]

        return [
            "name":"Trail",
            "coordinates":coordinates,
            "grade":1,
            "_id":"id1"
        ]
    }

    class func fakeCoordinates() -> [[Double]] {
        let coordinates = [[-36.843053, 174.766465],
                           [-36.84423, 174.771012],
                           [-36.8452, 174.770473],
                           [-36.844233, 174.766888]]
        return coordinates
    }

    class func fakeCoordinate() -> [Double] {
        return [-36.843053, 174.766465]
    }
}
