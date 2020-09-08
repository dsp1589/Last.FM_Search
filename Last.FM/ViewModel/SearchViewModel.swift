//
//  SearchViewModel.swift
//  Last.FM
//
//  Created by Dhanasekarapandian Srinivasan on 9/6/20.
//  Copyright © 2020 Dhanasekarapandian Srinivasan. All rights reserved.
//

import Foundation

enum SearchState {
    case searching
    case completed
    case idle
}

class SearchResultsTableViewModel {
    
    let delegator: SearchTableDelegator = SearchTableDelegator()
    
    private let searchOperationQueue = SearchOperationQueue()
    private var currentSearchOperation: SearchOperation?
    private var currentScop: (SearchType, SearchMethod) = (.albumSearch, .albumSearch)
    weak var controller: SearchTableViewController?
    var scopeIndex: Int = 0
    private var searchResult: ResponseSearch?
    var searchState: SearchState = .idle {
        didSet{
            DispatchQueue.main.async {
                self.controller?.tableView.reloadData()
            }
        }
    }
    var urlSession: URLSession = LastFMURLSession.shared

    
    init() {
        delegator.model = self
    }
    
    
    func searchQueryUpdate(text: String){
        searchOperationQueue.cancelAllOperations()
        currentScop = getScopeOfSearch(idx: scopeIndex)
        currentSearchOperation = SearchOperation(text: text, searchM: currentScop.1, searchType: currentScop.0, completionBlock: { [weak self] response in
            self?.searchResult = response
            self?.delegator.currentState = .completed
            self?.searchState = .completed
            }, session: self.urlSession)
        searchOperationQueue.addOperation(currentSearchOperation!)
        searchResult = nil
        searchState = .searching
        delegator.currentState = .searching
    }
    
    var totalRows: Int {
        if searchState == .searching { return 1 }
        switch currentScop.0 {
        case .albumSearch:
            return searchResult?.results.albummatches?.album.count ?? 0
        case .artistSearch:
            return searchResult?.results.artistmatches?.artist.count ?? 0
        default:
            return searchResult?.results.trackmatches?.track.count ?? 0
        }
    }
    
    func imageURL(idx: Int) -> String? {
        
        switch currentScop.0 {
        case .albumSearch:
            return searchResult?.results.albummatches?.album[idx].image.first(where: { (image) -> Bool in
                return image.size == .medium
            })?.text
        case .artistSearch:
            return searchResult?.results.artistmatches?.artist[idx].image?.first(where: { (image) -> Bool in
                return image.size == .medium
            })?.text
        default:
            return searchResult?.results.trackmatches?.track[idx].image?.first?.text
        }
    }
    
    func titleText(idx: Int) -> String? {
        
        switch currentScop.0 {
        case .albumSearch:
            return searchResult?.results.albummatches?.album[idx].name
        case .artistSearch:
            return searchResult?.results.artistmatches?.artist[idx].name
        default:
            return searchResult?.results.trackmatches?.track[idx].name
        }
    }
    
    func subTitleText(idx: Int) -> String? {
        switch currentScop.0 {
        case .albumSearch:
            return searchResult?.results.albummatches?.album[idx].artist
        case .artistSearch:
            return ""
        default:
            return searchResult?.results.trackmatches?.track[idx].artist
        }
    }
    
    func reset(){
        searchResult = nil
        searchState = .idle
    }
}

extension SearchResultsTableViewModel {
    private func getScopeOfSearch(idx : Int) -> (SearchType, SearchMethod) {
        var searchType: SearchType!
        var searchMethod: SearchMethod!
        let scopesTitle = Scope.allCases.map{$0.rawValue}
        switch Scope.init(rawValue: scopesTitle[idx]) {
        case .album:
            searchType = .albumSearch
            searchMethod = .albumSearch
            break
        case .artist:
            searchType = .artistSearch
            searchMethod = .artistSearch
            break
        case .track:
            searchType = .trackSearch
            searchMethod = .trackSearch
            break
        case .none:
            fatalError("Scope not covered, verify the enum declaration in AppConstants")
        }
        return (searchType, searchMethod)
    }
}

extension SearchResultsTableViewModel: NavigatableSearch {
    func didTapItem(idx: Int) {
        var params: [String: String] = [:]
        switch currentScop.0 {
        case .albumSearch:
            params["method"] = GetInfo.albumInfo.rawValue
            params["album"] = searchResult?.results.albummatches?.album[idx].name
            params["artist"] = searchResult?.results.albummatches?.album[idx].artist
            break
        case .artistSearch:
            params["method"] = GetInfo.artistInfo.rawValue
            params["artist"] = searchResult?.results.artistmatches?.artist[idx].name
            break
        default:
            params["method"] = GetInfo.trackInfo.rawValue
            params["artist"] = searchResult?.results.trackmatches?.track[idx].artist
            params["track"] = searchResult?.results.trackmatches?.track[idx].name
            break
        }
        controller?.showInfo(searchPaarams: params, type: currentScop.0)
    }
}
