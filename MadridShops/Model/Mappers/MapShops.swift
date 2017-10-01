//
//  MapShops.swift
//  MadridShops
//
//  Created by Francesc Callau Brull on 18/9/17.
//  Copyright © 2017 fcallau. All rights reserved.
//

import CoreData

func mapShopCDIntoShop(shopCD: ShopCD) -> ModelObject {
    let shop = ModelObject(name: shopCD.name!)
    
    shop.address = shopCD.address ?? ""
    shop.image = shopCD.image ?? ""
    shop.logo = shopCD.logo ?? ""
    
    shop.latitude = shopCD.latitude
    shop.longitude = shopCD.longitude
    shop.description_es = shopCD.description_es ?? ""
    shop.description_en = shopCD.description_en ?? ""
    shop.openingHours = shopCD.openingHours ?? ""
    shop.entityType = shopCD.entityType!
    
    shop.logoData = shopCD.logoData as NSData? ?? nil
    shop.imageData = shopCD.imageData as NSData? ?? nil
    shop.mapData = shopCD.mapData as NSData? ?? nil
    
    return shop
}

func mapShopIntoShopCD(context: NSManagedObjectContext, shop: ModelObject) -> ShopCD {
    // mapping shop into ShopCD
    let shopCD = ShopCD(context: context)
    
    shopCD.name = shop.name
    shopCD.address = shop.address
    shopCD.image = shop.image
    shopCD.logo = shop.logo
    
    shopCD.latitude = shop.latitude ?? 0.0
    shopCD.longitude = shop.longitude ?? 0.0
    shopCD.description_es = shop.description_es
    shopCD.description_en = shop.description_en
    shopCD.openingHours = shop.openingHours
    shopCD.entityType = shop.entityType
    
    print("shop.logo: \(shop.logo)")
    
    // Obtain the logo data, using the logo url
    if let url = URL(string: shop.logo),
        let data = NSData(contentsOf: url) {
        shopCD.logoData = data as Data
    }
    
    print("shop.image: \(shop.image)")
    
    // Obtain the image data, using the image url
    if let url = URL(string: shop.image),
        let data = NSData(contentsOf: url) {
        shopCD.imageData = data as Data
    }
    
    // Obtain the map data, using Google API
    if let url = URL(string: "https://maps.googleapis.com/maps/api/staticmap?%25&size=320x220&scale=2&markers=" + String(shopCD.latitude) + "," + String(shopCD.longitude)),
        let data = NSData(contentsOf: url) {
        shopCD.mapData = data as Data
    }
    
    return shopCD
}
