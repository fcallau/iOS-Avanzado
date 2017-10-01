//
//  SaveAllShopsInteractorImpl.swift
//  MadridShops
//
//  Created by Francesc Callau Brull on 15/9/17.
//  Copyright © 2017 fcallau. All rights reserved.
//

import Foundation
import CoreData

class SaveAllShopsInteractorImpl: SaveAllShopsInteractor {
    func execute(shops: ModelObjects, context: NSManagedObjectContext, onSuccess: @escaping () -> Void, onError: errorClosure) {
        for i in 0..<shops.count() {
            let shop = shops.get(index: i)
            
            let _ = mapShopIntoShopCD(context: context, shop: shop)
        }
        
        do {
            try context.save()
            onSuccess()
        } catch {
            // onError(nil)
        }
    }
    
    func execute(shops: ModelObjects, context: NSManagedObjectContext, onSuccess: @escaping () -> Void) {
        execute(shops: shops, context: context, onSuccess: onSuccess, onError: nil)
    }
    
    //    func execute(shops: ModelObjects, context: NSManagedObjectContext, onSuccess: @escaping (ModelObjects) -> Void, onError: errorClosure) {
    //        for i in 0..<shops.count() {
    //            let shop = shops.get(index: i)
    //
    //            let _ = mapShopIntoShopCD(context: context, shop: shop)
    //        }
    //
    //        do {
    //            try context.save()
    //            onSuccess(shops)
    //        } catch {
    //            // onError(nil)
    //        }
    //    }
    //    
    //    func execute(shops: ModelObjects, context: NSManagedObjectContext, onSuccess: @escaping (ModelObjects) -> Void) {
    //        execute(shops: shops, context: context, onSuccess: onSuccess, onError: nil)
    //    }
}
