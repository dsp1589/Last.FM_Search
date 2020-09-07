//
//  Lasf_FMValidateEndPoints.swift
//  Last.FMTests
//
//  Created by Dhanasekarapandian Srinivasan on 9/7/20.
//  Copyright © 2020 Dhanasekarapandian Srinivasan. All rights reserved.
//

import XCTest
@testable import Last_FM

class Lasf_FMValidateEndPointsTest: XCTestCase {

    func testEndPoints() throws {
        EndPoints.allCases.forEach { (ep) in
            XCTAssert(URL(string: ep.rawValue) != nil, "\(ep) is not valid url")
        }
    }

}
