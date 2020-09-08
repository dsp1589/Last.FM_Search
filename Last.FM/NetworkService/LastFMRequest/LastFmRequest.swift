//
//  LastFmRequest.swift
//  Last.FM
//
//  Created by Dhanasekarapandian Srinivasan on 9/5/20.
//  Copyright © 2020 Dhanasekarapandian Srinivasan. All rights reserved.
//

import Foundation

protocol Request {
    
    func endPoint() -> String
    func apiKey() -> String
    func buildRequest() -> URLRequest?
    func requestCompleted(data: Data?, response: URLResponse?,error: Error?)
}

extension Request {
    func endPoint() -> String {
         return EndPoints.lastFm.rawValue
    }
    func  apiKey() -> String {
        return "c0e345bacd64670563a7edefd0675f18"
    }
    func parseData<T: Codable>(data: Data, success: ((T?)->Void), failure: ((String)->Void)) {
        let result = Result { try? JSONDecoder.init().decode(T.self, from: data) }
        switch result {
        case .success(let parsed):
            success(parsed)
            break
        default:
            failure("Unexpected Error!")
        }
    }
}

protocol Searchable {
    var searchMethod: SearchMethod { get }
}

struct LastFmSearchRequest<T : Codable>: Searchable, Request {
   
    var searchMethod: SearchMethod
    var searchTerm : String
    var searchType: SearchType
    var success: ((T?)->Void)
    var failure: ((String)->Void)
    
    func buildRequest() -> URLRequest?{
        guard let url = URL.init(string: endPoint()) else {
            return nil
        }
        let apiParam = URLQueryItem(name: QParams.apiKey.rawValue, value: apiKey())
        let formatParam = URLQueryItem(name: QParams.format.rawValue, value: QParams.json.rawValue)
        let methodParam = URLQueryItem(name: QParams.method.rawValue, value: searchMethod.rawValue)
        let searchTypeParam = URLQueryItem(name: searchType.rawValue, value: searchTerm)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = [apiParam, formatParam, methodParam, searchTypeParam]
        
        guard let builtUrl = components?.url else {
            return nil
        }
        return URLRequest(url: builtUrl)
    }
    
    func requestCompleted(data: Data?, response: URLResponse?, error: Error?) {
        if response != nil, let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let responseData = data {
            parseData(data: responseData, success: success, failure: failure)
        } else {
            if let e = error {
                failure(e.localizedDescription)
            }else {
                failure("Unexpected Error!")
            }
        }
    }
}
