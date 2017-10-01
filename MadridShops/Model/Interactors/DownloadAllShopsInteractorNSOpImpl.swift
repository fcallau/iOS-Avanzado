//
//  DownloadAllShopsInteractorNSOpImpl.swift
//  MadridShops
//
//  Created by Francesc Callau Brull on 11/9/17.
//  Copyright © 2017 fcallau. All rights reserved.
//

import Foundation

class DownloadAllShopsInteractorNSOpImpl: DownloadAllShopsInteractor {
    func execute(urlString: String, onSuccess: @escaping (ModelObjects) -> Void, onError: errorClosure) {
        let urlString = "https://madrid-shops.com/json_new/getShops.php"
        
        let queue = OperationQueue()
        queue.addOperation {
            if let url = URL(string: urlString), let data = NSData(contentsOf: url) as Data? {
                let shops = parseShops(data: data, entityType: "shop")
                
                OperationQueue.main.addOperation {
                    onSuccess(shops)
                }
            }
        }
    }
    
    func execute(urlString: String, onSuccess: @escaping (ModelObjects) -> Void) {
        execute(urlString: urlString, onSuccess: onSuccess, onError: nil)
    }
}
