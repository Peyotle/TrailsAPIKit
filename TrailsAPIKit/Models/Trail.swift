//
//  Trail.swift
//  CycleNZ
//
//  Created by Oleg Chernyshenko on 24/06/16.
//  Copyright © 2016 Oleg. All rights reserved.
//

import UIKit

public enum TrailGrade: Int {
    case NotGraded = 0,
    Easiest = 1, Easy, Intermediate, Advanced, Expert
}

enum JSONError: ErrorProtocol {
    case InvalidJSON(invalidKey: String)
}

extension Int {
    func isInGradeRange() -> Bool {
        return (self >= TrailGrade.Easiest.rawValue &&
            self <= TrailGrade.Expert.rawValue) ? true : false
    }
}

public struct Trail {

    public let id: String
    public let name: String
    public let grade: TrailGrade
    public let coordinates: [Coordinate]

    public init(name: String, coordinates: [Coordinate], grade: TrailGrade = .NotGraded, id: String = "") {
        self.name = name
        self.coordinates = coordinates
        self.id = id
        self.grade = grade
    }

    init?(with dictionary: Dictionary<String, AnyObject>) throws {
        guard let coordinatesArray = dictionary["coordinates"] as? [[Double]]
            else {throw JSONError.InvalidJSON(invalidKey:"coordinates") }

        guard let name = dictionary["name"] as? String, name.characters.count > 0
            else { throw JSONError.InvalidJSON(invalidKey:"name") }

        guard let grade = dictionary["grade"] as? TrailGrade.RawValue
            else { throw JSONError.InvalidJSON(invalidKey:"grade") }

        guard let _id = dictionary["_id"] as? String, _id.characters.count > 0
            else { throw JSONError.InvalidJSON(invalidKey:"_id") }

        let checkedGrade = (grade.isInGradeRange()) ? grade : 0
        let coordinates = coordinatesArray.flatMap { coordinateArray in Coordinate(with: coordinateArray) }
        self.init(name: name, coordinates: coordinates, grade: TrailGrade(rawValue: checkedGrade)!, id: _id)
    }

    func toDictionary() -> Dictionary<String, AnyObject> {
        let coordinateArrays = coordinates.map {$0.toArray()}
        var dictionary: Dictionary<String, AnyObject> = ["name": name,
                                                         "coordinates": coordinateArrays,
                                                         "grade": grade.rawValue as Int]
        if self.id.characters.count > 0 { dictionary["_id"] = self.id }
        return dictionary
    }
}
