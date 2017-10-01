//
//  DownloadAllShopsInteractorNSURLSessionImpl.swift
//  MadridShops
//
//  Created by Francesc Callau Brull on 12/9/17.
//  Copyright © 2017 fcallau. All rights reserved.
//

import Foundation

class DownloadAllShopsInteractorNSURLSessionImpl: DownloadAllShopsInteractor {
    func execute(urlString: String, onSuccess: @escaping (ModelObjects) -> Void, onError: errorClosure) {
        let session = URLSession.shared
        
        if let url = URL(string: urlString) {
            let task = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
                OperationQueue.main.addOperation {
                    assert(Thread.current == Thread.main)
                    if error == nil {
                        // Ok
                        var entityType: String
                        
                        if urlString == "https://madrid-shops.com/json_new/getShops.php" {
                            entityType = "shop"
                        } else {
                            entityType = "activity"
                        }
                        
                        let shops = parseShops(data: data!, entityType: entityType)
                        onSuccess(shops)
                    } else {
                        // Error
                        if let myError = onError {
                            myError(error!)
                        }
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func execute(urlString: String, onSuccess: @escaping (ModelObjects) -> Void) {
        execute(urlString: urlString, onSuccess: onSuccess, onError: nil)
    }
}
