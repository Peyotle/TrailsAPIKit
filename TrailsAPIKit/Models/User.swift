//
//  User.swift
//  CycleNZ
//
//  Created by Oleg Chernyshenko on 5/07/16.
//  Copyright © 2016 Oleg Chernyshenko. All rights reserved.
//

import UIKit

public struct User {

    let name: String
    let id: String

    init(with name: String, id: String) {
        self.name = name
        self.id = id
    }

    init?(with dictionary: Dictionary<String, AnyObject>) throws {
        guard let name = dictionary["userName"] as? String
            else { throw JSONError.InvalidJSON(invalidKey:"username") }
        guard let _id = dictionary["_id"] as? String
            else { throw JSONError.InvalidJSON(invalidKey:"_id") }

        self.init(with: name, id: _id)
    }
}
