//
//  Place.swift
//  CycleNZ
//
//  Created by Oleg Chernyshenko on 13/07/16.
//  Copyright © 2016 Oleg Chernyshenko. All rights reserved.
//

enum PlaceType: Int {
    case Unknown
    case Danger
    case PointOfInterest
    case PitStop
    case GooglePlace
}

extension Int {
    func isInPlaceTypeRange() -> Bool {
        return (self >= PlaceType.Unknown.rawValue &&
            self <= PlaceType.GooglePlace.rawValue) ? true : false
    }
}

struct Place {

    let id: String
    let name: String
    let type: PlaceType
    let coordinate: Coordinate

    init(name: String, coordinate: Coordinate, type: PlaceType = .Unknown, id: String = "") {
        self.name = name
        self.coordinate = coordinate
        self.id = id
        self.type = type
    }

    init?(with dictionary: Dictionary<String, AnyObject>) throws {
        guard let coordinates = dictionary["coordinate"] as? [Double],
            let coordinate = Coordinate(with: coordinates)
            else {throw JSONError.InvalidJSON(invalidKey:"coordinate") }

        guard let name = dictionary["name"] as? String, name.characters.count > 0
            else { throw JSONError.InvalidJSON(invalidKey:"name") }

        guard let type = dictionary["type"] as? PlaceType.RawValue
            else { throw JSONError.InvalidJSON(invalidKey:"type") }

        guard let _id = dictionary["_id"] as? String, _id.characters.count > 0
            else { throw JSONError.InvalidJSON(invalidKey:"_id") }

        let checkedType = (type.isInPlaceTypeRange()) ? type : 0

        self.init(name: name, coordinate: coordinate, type: PlaceType(rawValue: checkedType)!, id: _id)
    }

    func toDictionary() -> Dictionary<String, AnyObject> {
        var dictionary: Dictionary<String, AnyObject> = ["name": name,
                                                         "coordinate": coordinate.toArray(),
                                                         "type": type.rawValue as Int]
        if self.id.characters.count > 0 { dictionary["_id"] = self.id }
        return dictionary
    }
}
