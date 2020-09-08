//
//  SearchModel_AlbumTest.swift
//  Last.FMTests
//
//  Created by Dhanasekarapandian Srinivasan on 9/8/20.
//  Copyright © 2020 Dhanasekarapandian Srinivasan. All rights reserved.
//

import XCTest
@testable import Last_FM


class SearchModel_AlbumTest: XCTestCase {

  
    func testAlbumModelSearch() throws {
        let bundle = Bundle.init(for: self.classForCoder)
        let bURL = bundle.url(forResource: "album_search_result", withExtension: "json")
        let data = try! Data.init(contentsOf: bURL!)
        let mockSession = LastFMURLMockSession(data: data, code: 200)
        let modelToBeTested = SearchResultsTableViewModel()
        modelToBeTested.scopeIndex = 1
        modelToBeTested.urlSession = mockSession
        modelToBeTested.searchQueryUpdate(text: "TEST_artist")
        var expired = false
        DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
            expired = true
        }
        while modelToBeTested.searchState == SearchState.searching && !expired{
        }
        let resultModel = try! JSONDecoder.init().decode(ResponseSearch.self, from: data)
        let album = resultModel.results.albummatches?.album.first
        XCTAssert(modelToBeTested.totalRows == 50, "Invalid number of items")
        XCTAssert(modelToBeTested.imageURL(idx: 0) == album?.image.first(where: { (img) in
            return img.size == .medium
            })?.text, "Invalid image url for search result item 1")
        XCTAssert(modelToBeTested.titleText(idx: 0) == album?.name, "Invalid title for search result item 1")
        XCTAssert(modelToBeTested.subTitleText(idx: 0) == album?.artist, "Invalid subtitle for search result item 1")
    }
 

}
