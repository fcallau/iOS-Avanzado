//
//  ExecuteOnceInteractorImpl.swift
//  MadridShops
//
//  Created by Francesc Callau Brull on 18/9/17.
//  Copyright © 2017 fcallau. All rights reserved.
//

import Foundation

class ExecuteOnceInteractorImpl: ExecuteOnceInteractor {
    func execute(closure: () -> Void) {
        let defaults = UserDefaults.standard
        
        if let _ = defaults.string(forKey: "once") {
            // already saved
        } else { // first time
            closure()
        }
    }
    
    func execute2(initializeClosure: () -> Void, initializedClosure: () -> Void) {
        let defaults = UserDefaults.standard
        
        if let _ = defaults.string(forKey: "once") { // already saved
            initializedClosure()
        } else { // first time
            initializeClosure()
        }
    }
}
