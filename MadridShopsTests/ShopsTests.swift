//
//  ShopsTests.swift
//  MadridShopsTests
//
//  Created by Francesc Callau Brull on 7/9/17.
//  Copyright © 2017 fcallau. All rights reserved.
//

import XCTest
import MadridShops

class ShopsTests: XCTestCase {
    // sut: system under test
    func testGivenEmptyShopsNumberShopsIsZero() {
        let sut = ModelObjects()
        XCTAssertEqual(0, sut.count())
    }
    
    func testGivenShopsWithOneElementNumberShopsIsOne() {
        let sut = ModelObjects()
        sut.add(modelObject: ModelObject(name: "modelObjectTest"))
        XCTAssertEqual(1, sut.count())
    }
}
