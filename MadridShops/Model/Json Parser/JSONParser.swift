//
//  JSONParser.swift
//  MadridShops
//
//  Created by Francesc Callau Brull on 12/9/17.
//  Copyright © 2017 fcallau. All rights reserved.
//

import Foundation

func parseShops(data: Data, entityType: String) -> ModelObjects {
    let shops = ModelObjects()
    
    do {
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! Dictionary<String, Any>
        let result = jsonObject["result"] as! [Dictionary<String, Any>]
        
        for shopJson in result {
            let shop = ModelObject(name: shopJson["name"]! as! String)
            
            shop.latitude = (((shopJson["gps_lat"] as! String) as NSString).floatValue)
            shop.longitude = (((shopJson["gps_lon"] as! String) as NSString).floatValue)
            shop.address = shopJson["address"]! as! String
            shop.logo = shopJson["logo_img"] as! String
            shop.image = shopJson["img"] as! String
            shop.description_es = shopJson["description_es"] as! String
            shop.description_en = shopJson["description_en"] as! String
            shop.entityType = entityType
            
            shops.add(modelObject: shop)
            
            break
        }
    } catch {
        print("Error parsing JSON")
    }
    
    return shops
}
