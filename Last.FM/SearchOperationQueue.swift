//
//  SearchOperationQueue.swift
//  Last.FM
//
//  Created by Dhanasekarapandian Srinivasan on 9/5/20.
//  Copyright © 2020 Dhanasekarapandian Srinivasan. All rights reserved.
//

import Foundation


class SearchOperationQueue: OperationQueue {
    
    override init() {
        super.init()
        self.maxConcurrentOperationCount = 1
    }
}

class SearchOperation: Operation {
    
    var searchText: String = ""
    var searchRequest: LastFmSearchRequest<ResponseSearch>?
    var operationCompleted: ((ResponseSearch?) -> Void)?
    
    var urlSession: URLSession = LastFMURLSession.shared
    
    convenience init(text: String,searchM: SearchMethod, searchType: SearchType,completionBlock: @escaping ((ResponseSearch?) -> Void), session: URLSession) {
        self.init()
        searchText = text
        operationCompleted = completionBlock
        self.urlSession = session
        searchRequest = LastFmSearchRequest<ResponseSearch>(searchMethod: searchM, searchTerm: searchText, searchType: searchType, success: { [weak self] (response) in
            guard let weakSelf = self else {
                return
            }
            if !weakSelf.isCancelled {
                print("Hello Result" + weakSelf.searchText)
                weakSelf.operationCompleted?(response)
            } else {
                print("Hello Cancelled" + weakSelf.searchText)
            }
        }, failure: { (errorMessage) in
            print(errorMessage)
        })
    }
    
    private override  init() {
        super.init()
    }
    
    override func main() {
        NetworkService.init(s: urlSession).get(request: searchRequest!)
    }
    
}
