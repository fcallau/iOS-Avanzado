//
//  SetExecutedOnceInteractorImpl.swift
//  MadridShops
//
//  Created by Francesc Callau Brull on 18/9/17.
//  Copyright © 2017 fcallau. All rights reserved.
//

import Foundation

class SetExecutedOnceInteractorImpl: SetExecutedOnceInteractor {
    func execute() {
        let defaults = UserDefaults.standard
        
        defaults.set("SAVED", forKey: "once")
        
        defaults.synchronize()
    }
    
    
}
