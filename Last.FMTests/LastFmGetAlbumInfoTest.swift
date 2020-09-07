//
//  LastFmGetAlbumInfoTest.swift
//  Last.FMTests
//
//  Created by Dhanasekarapandian Srinivasan on 9/7/20.
//  Copyright © 2020 Dhanasekarapandian Srinivasan. All rights reserved.
//

import XCTest
@testable import Last_FM

class LastFmGetAlbumInfoTest: XCTestCase {
    
    func testLastFmGetAlbumInfo() throws {
        
        let albumInfo = "album.getInfo"
        let method = "method"
        let alb = "album"
        let albName = "BreakIt"
        let artist = "artist"
        let artName = "MJ"
        let format = "format"
        let json = "json"
        let apiKey = "api_key"
        let key = "c0e345bacd64670563a7edefd0675f18"
        
        let request = LastFmGetAlbumInfo<AlbumInfoWrapper>(params: [method: albumInfo, alb:albName, artist:artName], success: { (albumInfo) in
            
        }) { (message) in
            
        }
        
        let urlRequest = request.buildRequest()
        XCTAssert(urlRequest != nil , "Request not built")
        let url = urlRequest?.url
        let qItems = URLComponents(url: url!, resolvingAgainstBaseURL: false)
        
        XCTAssert(qItems?.queryItems?.contains(where: { (ele) in
            return ele.name == method && ele.value == albumInfo
        }) == true, "Method not sent in request")
        
        XCTAssert(qItems?.queryItems?.contains(where: { (ele) in
            return ele.name == alb && ele.value == albName
        }) == true, "Album name not sent in request")
        
        XCTAssert(qItems?.queryItems?.contains(where: { (ele) in
            return ele.name == artist && ele.value == artName
        }) == true, "Artist name not sent in request")
        
        XCTAssert(qItems?.queryItems?.contains(where: { (ele) in
            return ele.name == format && ele.value == json
        }) == true, "JSON format not requested not sent in request")
        
        XCTAssert(qItems?.queryItems?.contains(where: { (ele) in
            return ele.name == apiKey && ele.value == key
        }) == true, "API Key required in request")
    }
    
}
