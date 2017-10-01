//
//  ModelObject.swift
//  MadridShops
//
//  Created by Francesc Callau Brull on 26/9/17.
//  Copyright © 2017 fcallau. All rights reserved.
//

import Foundation

public class ModelObject {
    var name: String
    var description_es: String = ""
    var description_en: String = ""
    var latitude: Float? = nil
    var longitude: Float? = nil
    var image: String = ""
    var logo: String = ""
    var openingHours: String = ""
    var address: String = ""
    var entityType: String = ""
    var imageData: NSData? = nil
    var logoData: NSData? = nil
    var mapData: NSData? = nil
    
    public init(name: String) {
        self.name = name
    }
}
