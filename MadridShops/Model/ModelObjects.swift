//
//  Shops.swift
//  MadridShops
//
//  Created by Francesc Callau Brull on 7/9/17.
//  Copyright © 2017 fcallau. All rights reserved.
//

import Foundation

public protocol AggregateProtocol {
    func count() -> Int
    func add(modelObject: ModelObject)
    func get(index: Int) -> ModelObject
}

public class ModelObjects: AggregateProtocol {
    private var modelObjectsList: [ModelObject]?
    
    public init() {
        self.modelObjectsList = []
    }
    
    public func count() -> Int {
        return (modelObjectsList?.count)!
    }
    
    public func add(modelObject: ModelObject) {
        modelObjectsList?.append(modelObject)
    }
    
    public func get(index: Int) -> ModelObject {
        return (modelObjectsList?[index])!
    }
}
