//
//  SaveAllShopsInteractor.swift
//  MadridShops
//
//  Created by Francesc Callau Brull on 15/9/17.
//  Copyright © 2017 fcallau. All rights reserved.
//

import Foundation
import CoreData

protocol SaveAllShopsInteractor {
    // execute: save all shops. Return on the main thread
    //    func execute(shops: ModelObjects, context: NSManagedObjectContext, onSuccess: @escaping (ModelObjects) -> Void, onError: errorClosure)
    //    func execute(shops: ModelObjects, context: NSManagedObjectContext, onSuccess: @escaping (ModelObjects) -> Void)
    
    func execute(shops: ModelObjects, context: NSManagedObjectContext, onSuccess: @escaping () -> Void, onError: errorClosure)
    func execute(shops: ModelObjects, context: NSManagedObjectContext, onSuccess: @escaping () -> Void)
}
