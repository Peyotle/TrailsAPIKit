//
//  FakeAPIDataSource.swift
//  CycleNZ
//
//  Created by Oleg Chernyshenko on 13/07/16.
//  Copyright © 2016 Oleg Chernyshenko. All rights reserved.
//

import UIKit

class FakeAPIDataSource: APIDataSource {

    func getTrails(completion: (trailsData: Data?, error: Error?) -> Void) {
        print("^getTrails")
        let arrayWithDict = [FakeAPIDataSource.fakeTrailDictionary()]
        let data = try? JSONSerialization.data(withJSONObject: arrayWithDict, options: [])

        completion(trailsData: data, error: nil)
    }

    func deleteTrail(with id: String, completion: (success: Bool, error: Error?) -> Void) {
        completion(success: true, error: nil)
    }

    func postTrail(data: Data, completion: (result: Data?, error: Error?) -> Void) {
        let data = try? JSONSerialization.data(withJSONObject: FakeAPIDataSource.fakeTrailDictionary(),
                                               options: [])

        completion(result: data, error: nil)
    }
    
    public func getSites(completion: (sitesData: Data?, error: Error?) -> Void) {
        
    }

    public func postSite(data: Data, completion: (result: Data?, error: Error?) -> Void) {

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
