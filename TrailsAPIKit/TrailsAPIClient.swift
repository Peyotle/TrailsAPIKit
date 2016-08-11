//
//  APIClient.swift
//  CycleNZ
//
//  Created by Oleg Chernyshenko on 25/06/16.
//  Copyright © 2016 Oleg Chernyshenko. All rights reserved.
//

import UIKit

public protocol TrailsAPIClient {
    
    associatedtype TrailDictionary = Dictionary<String, AnyObject>
    associatedtype getTrailsCompletion = (trails: TrailDictionary?, error: Error?) -> Void
    
    func getTrails(completion: getTrailsCompletion)
    func post(trail: TrailDictionary, completion:(trail: TrailDictionary?, error: Error?) -> Void)
    func deleteTrail(with id: String, completion: (success: Bool, error: Error?) -> Void)
}

public final class APIClient {

//    public typealias TrailDictionary = Dictionary<String, AnyObject>
//    public typealias getTrailsCompletion = (trails: TrailDictionary?, error: ErrorProtocol?) -> Void
//    
//    lazy var dataSource: APIDataSource = NetworkAPIDataSource()
//
//    
//    public init() {}
//    
//    public func getTrails(completion: getTrailsCompletion) {
//        self.dataSource.getTrails { (trailsData, error) in
//            self.processGetTrailsCompletion(trailsData: trailsData,
//                                            error: error,
//                                            completion: completion)
//        }
//    }
//    
//    func processGetTrailsCompletion(trailsData: Data?, error: ErrorProtocol?, completion: getTrailsCompletion) {
//        guard error == nil else {
//            completion(trails: nil, error: error)
//            return
//        }
//        guard let data = trailsData,
//            let trails = TrailParser.parseTrails(from: data) else {
//                completion(trails: nil, error: nil)
//                return
//        }
//        completion(trails: trails, error: nil)
//    }
//    
//    public func post(trail: Trail, completion:(trail: Trail?, error: ErrorProtocol?) -> Void) {
//        let trailDict = trail.toDictionary()
//        do {
//            let trailData = try JSONSerialization.data(withJSONObject: trailDict)
//            self.dataSource.postTrail(data: trailData, completion: { (result, error) in
//                if let error = error {
//                    completion(trail: nil, error: error)
//                } else if let trailData = result {
//                    TrailParser.parseTrail(from: trailData, with: completion)
//                }
//            })
//        } catch {
//            print("^\(error)")
//            return
//        }
//    }
//    
//    public func delete(trail: Trail, completion: (success: Bool, error: ErrorProtocol?) -> Void) {
//        self.dataSource.deleteTrail(with: trail.id) { (success, error) in
//            completion(success: success, error: error)
//        }
//    }
}
