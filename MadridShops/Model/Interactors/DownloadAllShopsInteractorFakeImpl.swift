//
//  DownloadAllShopsInteractorFakeImpl.swift
//  MadridShops
//
//  Created by Francesc Callau Brull on 7/9/17.
//  Copyright © 2017 fcallau. All rights reserved.
//

import Foundation

class DownloadAllShopsInteractorFakeImpl: DownloadAllShopsInteractor {
    func execute(urlString: String, onSuccess: @escaping (ModelObjects) -> Void, onError: errorClosure) {
        let shops = ModelObjects()
        
        for i in 0...10 {
            let shop = ModelObject(name: "Shop number \(i)")
            shop.address = "Address \(1)"
            shops.add(modelObject: shop)
        }
        
        OperationQueue.main.addOperation {
            onSuccess(shops)
        }
    }
    
    func execute(urlString: String, onSuccess: @escaping (ModelObjects) -> Void) {
        execute(urlString: urlString, onSuccess: onSuccess, onError: nil)
    }
    
    //    func execute(onSuccess: @escaping (ModelObjects) -> Void) {
    //        execute(onSuccess: onSuccess, onError: nil)
    //    }
    //
    //    func execute(onSuccess: @escaping (ModelObjects) -> Void, onError: errorClosure = nil) {
    //        let shops = ModelObjects()
    //
    //        for i in 0...10 {
    //            let shop = ModelObject(name: "Shop number \(i)")
    //            shop.address = "Address \(1)"
    //            shops.add(modelObject: shop)
    //        }
    //
    //        OperationQueue.main.addOperation {
    //            onSuccess(shops)
    //        }
    //    }
}
