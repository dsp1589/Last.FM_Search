//
//  NetworkService.swift
//  Last.FM
//
//  Created by Dhanasekarapandian Srinivasan on 9/5/20.
//  Copyright © 2020 Dhanasekarapandian Srinivasan. All rights reserved.
//

import Foundation

final class NetworkService {
    
    static let shared = NetworkService()
    let session = URLSession.shared
    
    func get(request: Request) {
        guard let urlRequest = request.buildRequest() else {
            return
        }
        session.dataTask(with: urlRequest) { (data, response, error) in
            request.requestCompleted(data: data, response: response, error: error)
        }.resume()
    }
}
