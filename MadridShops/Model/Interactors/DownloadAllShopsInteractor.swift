//
//  DownloadAllShopsInteractor.swift
//  MadridShops
//
//  Created by Francesc Callau Brull on 7/9/17.
//  Copyright © 2017 fcallau. All rights reserved.
//

import Foundation

protocol DownloadAllShopsInteractor {
    // execute: download all shops. Return on the main thread
    func execute(urlString: String, onSuccess: @escaping (ModelObjects) -> Void, onError: errorClosure)
    func execute(urlString: String, onSuccess: @escaping (ModelObjects) -> Void)
}

