//
//  ValidateSearchMethodsTest.swift
//  Last.FMTests
//
//  Created by Dhanasekarapandian Srinivasan on 9/7/20.
//  Copyright © 2020 Dhanasekarapandian Srinivasan. All rights reserved.
//

import XCTest
@testable import Last_FM

class ValidateSearchMethodsTest: XCTestCase {

    let searchMethods = [
        "track.search",
        "artist.search",
        "album.search",
    ]
    
    var total: Int {
        return searchMethods.count
    }

    func testSearchMethods() throws {
        XCTAssert(SearchMethod.allCases.count == total, "Extra Search Type param added but testcase/code not added/updated")
        SearchMethod.allCases.forEach { (params) in
            XCTAssert(searchMethods.contains(params.rawValue), "SearchMethods not handled")
        }
    }
}
