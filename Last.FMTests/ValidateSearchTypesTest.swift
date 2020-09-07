//
//  ValidateSearchTypesTest.swift
//  Last.FMTests
//
//  Created by Dhanasekarapandian Srinivasan on 9/7/20.
//  Copyright © 2020 Dhanasekarapandian Srinivasan. All rights reserved.
//

import XCTest

@testable import Last_FM

class ValidateSearchTypesTest: XCTestCase {
    
    var total : Int {
        return searchTypes.count
    }
    
    let searchTypes = [
        "track",
        "artist",
        "album"
    ]

    func testSearchTypes() throws {
        XCTAssert(SearchType.allCases.count == total, "Extra Search Type param added but testcase/code not added/updated")
       SearchType.allCases.forEach { (params) in
           XCTAssert(searchTypes.contains(params.rawValue), "SearchTypes not handled")
       }
    }
}
