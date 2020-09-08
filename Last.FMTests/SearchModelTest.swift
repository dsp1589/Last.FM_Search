//
//  SearchModelTest.swift
//  Last.FMTests
//
//  Created by Dhanasekarapandian Srinivasan on 9/8/20.
//  Copyright © 2020 Dhanasekarapandian Srinivasan. All rights reserved.
//

import XCTest
@testable import Last_FM

class SearchModel_ArtistTest: XCTestCase {

    
    func testArtistModelSearch() throws {
        let bundle = Bundle.init(for: self.classForCoder)
        let bURL = bundle.url(forResource: "artist_search_result", withExtension: "json")
        let data = try! Data.init(contentsOf: bURL!)
        let mockSession = LastFMURLMockSession(data: data, code: 200)
        let modelToBeTested = SearchResultsTableViewModel()
        modelToBeTested.urlSession = mockSession
        modelToBeTested.searchQueryUpdate(text: "TEST_artist")
        var expired = false
        DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
            expired = true
        }
        while modelToBeTested.searchState == SearchState.searching && !expired{
        }
        let resultModel = try! JSONDecoder.init().decode(ResponseSearch.self, from: data)
        let artist = resultModel.results.artistmatches?.artist.first
        XCTAssert(modelToBeTested.totalRows == 30, "Invalid number of items")
        XCTAssert(modelToBeTested.imageURL(idx: 0) == artist?.image?.first(where: { (img) in
            return img.size == .medium
            })?.text, "Invalid image url for search result item 1")
        XCTAssert(modelToBeTested.titleText(idx: 0) == artist?.name, "Invalid title for search result item 1")
        XCTAssert(modelToBeTested.subTitleText(idx: 0) == "", "Invalid subtitle for search result item 1")
    }

}
