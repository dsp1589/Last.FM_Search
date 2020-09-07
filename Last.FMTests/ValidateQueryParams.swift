//
//  ValidateQueryParams.swift
//  Last.FMTests
//
//  Created by Dhanasekarapandian Srinivasan on 9/7/20.
//  Copyright © 2020 Dhanasekarapandian Srinivasan. All rights reserved.
//

import XCTest
@testable import Last_FM

class ValidateQueryParams: XCTestCase {
    
    var totalParamsSupported: Int {
        return paramKeys.count
    }
    let paramKeys = ["json",
                     "format",
                     "api_key",
                     "method",
                     "artist",
                     "album",
                     "track"]
    
    func testQParams() throws {
        XCTAssert(QParams.allCases.count == totalParamsSupported, "Extra query param added but testcase/code not added/updated")
        QParams.allCases.forEach { (qParams) in
            XCTAssert(paramKeys.contains(qParams.rawValue), "Query Params not handled")
        }
    }
    
}
