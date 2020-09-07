//
//  ValidateInfoMethodsTest.swift
//  Last.FMTests
//
//  Created by Dhanasekarapandian Srinivasan on 9/7/20.
//  Copyright © 2020 Dhanasekarapandian Srinivasan. All rights reserved.
//

import XCTest
@testable import Last_FM

class ValidateInfoMethodsTest: XCTestCase {
    
    var totalParamsSupported: Int {
        return methods.count
    }
    let methods = [
        "artist.getInfo",
        "track.getInfo",
        "album.getInfo"
    ]
    
    func testInfoMethods() throws {
        XCTAssert(GetInfo.allCases.count == totalParamsSupported, "Extra Get Info param added but testcase/code not added/updated")
        GetInfo.allCases.forEach { (params) in
            XCTAssert(methods.contains(params.rawValue), "Query Params not handled")
        }
    }
    
}
