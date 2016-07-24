//
//  Coordinate.swift
//  CycleNZ
//
//  Created by Oleg Chernyshenko on 24/06/16.
//  Copyright © 2016 Oleg. All rights reserved.
//

public struct Coordinate {

    public let latitude: Double
    public let longitude: Double

    public init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }

    public init?(with array: [Double]) {
        guard array.count == 2 else {
            return nil
        }

        self.init(latitude: array[0], longitude: array[1])
    }

    func toArray() -> [Double] {
        return [latitude, longitude]
    }
}
