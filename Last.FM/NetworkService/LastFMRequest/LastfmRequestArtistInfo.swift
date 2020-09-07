//
//  LastfmRequestArtistInfo.swift
//  Last.FM
//
//  Created by Dhanasekarapandian Srinivasan on 9/7/20.
//  Copyright © 2020 Dhanasekarapandian Srinivasan. All rights reserved.
//

import Foundation


struct LastFmGetArtistInfo<T : Codable>: Request {
    
    let params: [String:String]
    let success: ((T?)->Void)
    let failure: ((String)->Void)
    
    func buildRequest() -> URLRequest? {
        guard let url = URL.init(string: endPoint()) else {
            return nil
        }
        let apiParam = URLQueryItem(name: QParams.apiKey.rawValue, value: apiKey())
        let jsonParam = URLQueryItem(name: QParams.format.rawValue, value: QParams.json.rawValue)
        let methodParam = URLQueryItem(name: QParams.method.rawValue, value: params[QParams.method.rawValue])
        let artistParam = URLQueryItem(name: QParams.artist.rawValue, value: params[QParams.artist.rawValue])
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = [apiParam, jsonParam, methodParam, artistParam]
        
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
