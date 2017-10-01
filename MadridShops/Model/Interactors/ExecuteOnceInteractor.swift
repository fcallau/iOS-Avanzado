//
//  ExecuteOnceInteractor.swift
//  MadridShops
//
//  Created by Francesc Callau Brull on 18/9/17.
//  Copyright © 2017 fcallau. All rights reserved.
//

import Foundation

protocol ExecuteOnceInteractor {
    func execute(closure: () -> Void)
}
