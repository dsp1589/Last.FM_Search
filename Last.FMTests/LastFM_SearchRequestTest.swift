//
//  LastFM_SearchRequest.swift
//  Last.FMTests
//
//  Created by Dhanasekarapandian Srinivasan on 9/7/20.
//  Copyright © 2020 Dhanasekarapandian Srinivasan. All rights reserved.
//

import XCTest
@testable import Last_FM

class LastFM_SearchRequestTest: XCTestCase {

    func testSearchRequest() throws {
        let searchTerm = "HelloWorld"
       let request =  LastFmSearchRequest<ResponseSearch>.init(searchMethod: .albumSearch, searchTerm: searchTerm, searchType: .albumSearch, success: { (_) in
        }) { (_) in
        }
        let urlRequest = request.buildRequest()
        XCTAssert(urlRequest != nil , "Request not built")
        let url = urlRequest?.url
        let qItems = URLComponents(url: url!, resolvingAgainstBaseURL: false)
        XCTAssert(qItems?.queryItems?.first(where: { (item) in
            return item.name == QParams.method.rawValue
        })?.value == SearchMethod.albumSearch.rawValue, "MEthod not set or failed to set")
        
        XCTAssert(qItems?.queryItems?.first(where: { (item) in
            return item.name == QParams.format.rawValue
        })?.value == QParams.json.rawValue, "Json format not set XML will be returned")
        
        XCTAssert(qItems?.queryItems?.first(where: { (item) in
            return item.name == QParams.apiKey.rawValue
        })?.value == "c0e345bacd64670563a7edefd0675f18", "API key not set ")
        
        XCTAssert(qItems?.queryItems?.first(where: { (item) in
            return item.name == SearchType.albumSearch.rawValue
        })?.value == searchTerm, "Search Keyword missing")
    }
}
