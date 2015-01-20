//
//  LotAnnotation.swift
//  Lizard
//
//  Created by Ty Parker on 11/9/14.
//  Copyright (c) 2014 Ty Parker. All rights reserved.
//

import UIKit
import MapKit

class LotAnnotation: NSObject, MKAnnotation {
    var id: String
    //var lot: Lot?
    var coordinate: CLLocationCoordinate2D
    var title: String
    var subtitle: String
    var owner: PFUser
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String/*, lot: Lot? = nil,*/,id: String, owner: PFUser) {
        self.id = id
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.owner = owner
        //self.lot = lot
    }
    
}

