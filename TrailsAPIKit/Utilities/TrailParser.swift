//
//  TrailParser.swift
//  CycleNZ
//
//  Created by Oleg Chernyshenko on 14/07/16.
//  Copyright © 2016 Oleg Chernyshenko. All rights reserved.
//

import UIKit
class TrailParser {

    typealias TrailDictionary = Dictionary<String, AnyObject>

    class func parseTrail(from data: Data, with completion:(result: Trail?, error: ErrorProtocol?) -> Void) {
        if let trailDictionary = try? JSONSerialization.jsonObject(with: data) as! TrailDictionary {
            do {
                let updatedTrail = try Trail(with: trailDictionary)
                completion(result: updatedTrail, error: nil)
            } catch {
                completion(result: nil, error: error)
            }
        }
    }

    class func parseTrails(from data: Data) -> [Trail]? {
        guard let trailDicts = try? JSONSerialization.jsonObject(with: data, options: []) else {
            return nil
        }

        var trails: [Trail] = []
        for trailDict in trailDicts as! [TrailDictionary] {
            do {
                let trail = try Trail(with: trailDict)
                trails.append(trail!)
            } catch JSONError.InvalidJSON(let invalidKey) {
                print("^Error loading trail with key: \(invalidKey)")
            } catch {
                print("^\(error)")
            }
        }
        return trails
    }
}
