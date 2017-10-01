//
//  MapPin.swift
//  MadridShops
//
//  Created by Francesc Callau Brull on 21/9/17.
//  Copyright © 2017 fcallau. All rights reserved.
//

import Foundation
import MapKit

class MapPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var logo: String?
    var entityType: String
    var imageData: Data?
    var logoData: Data?
    var entity: ShopCD
    
    init(coordinate: CLLocationCoordinate2D, entityType: String, entity: ShopCD) {
        self.coordinate = coordinate
        self.entityType = entityType
        self.entity = entity
    }
}
