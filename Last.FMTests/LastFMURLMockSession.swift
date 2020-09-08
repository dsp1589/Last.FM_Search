//
//  LastFMURLMockSession.swift
//  Last.FMTests
//
//  Created by Dhanasekarapandian Srinivasan on 9/8/20.
//  Copyright © 2020 Dhanasekarapandian Srinivasan. All rights reserved.
//

import XCTest

class LastFMURLMockSession: URLSession {
    
    var responseData: Data?
    var successCpde: Int
    init(data: Data?, code: Int) {
        self.responseData = data
        self.successCpde = code
    }
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> SessionMockDataTask {
        return SessionMockDataTask.init(handler: completionHandler, data: self.responseData, code:  self.successCpde)
    }
}

class SessionMockDataTask: URLSessionDataTask {
    
    let cHandler: (Data?, URLResponse?, Error?) -> Void
    let responseData: Data?
    let code: Int
    
    init(handler: @escaping (Data?, URLResponse?, Error?) -> Void, data: Data?, code: Int) {
        self.cHandler = handler
        self.responseData = data
        self.code = code
    }
    
    override func resume() {
        let response =  HTTPURLResponse.init(url: URL.init(string: "https://mockURL")!, statusCode: self.code, httpVersion: nil, headerFields: nil)
        self.cHandler(self.responseData, response, nil)
    }
    
}
