//
//  LotList.swift
//  Lizard
//
//  Created by Ty Parker on 11/8/14.
//  Copyright (c) 2014 Ty Parker. All rights reserved.
//

import UIKit
import Realm
class Lot: RLMObject{
//class Lot: PFObject {
    dynamic var id = Int(arc4random_uniform(10000))
    dynamic var spots = Int(1)
    dynamic var price = ""
    dynamic var latitude: Double = 0.0
    dynamic var longitude: Double = 0.0
    dynamic var created = NSDate()
    override class func primaryKey() -> String {
        return "id"
    }
}