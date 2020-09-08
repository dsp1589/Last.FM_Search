//
//  SearchAlbum_TrackTest.swift
//  Last.FMTests
//
//  Created by Dhanasekarapandian Srinivasan on 9/8/20.
//  Copyright © 2020 Dhanasekarapandian Srinivasan. All rights reserved.
//

import XCTest
@testable import Last_FM


class SearchAlbum_TrackTest: XCTestCase {

   func testAlbumModelSearch() throws {
          let bundle = Bundle.init(for: self.classForCoder)
          let bURL = bundle.url(forResource: "track_search_result", withExtension: "json")
          let data = try! Data.init(contentsOf: bURL!)
          let mockSession = LastFMURLMockSession(data: data, code: 200)
          let modelToBeTested = SearchResultsTableViewModel()
          modelToBeTested.scopeIndex = 2
          modelToBeTested.urlSession = mockSession
          modelToBeTested.searchQueryUpdate(text: "TEST_artist")
          var expired = false
          DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
              expired = true
          }
          while modelToBeTested.searchState == SearchState.searching && !expired {
          }
          let resultModel = try! JSONDecoder.init().decode(ResponseSearch.self, from: data)
          let tracks = resultModel.results.trackmatches?.track.first
          XCTAssert(modelToBeTested.totalRows == 30, "Invalid number of items")
            XCTAssert(modelToBeTested.imageURL(idx: 0) == tracks?.image?.first?.text, "Invalid image url for search result item 1")
            XCTAssert(modelToBeTested.titleText(idx: 0) == tracks?.name, "Invalid title for search result item 1")
            XCTAssert(modelToBeTested.subTitleText(idx: 0) == tracks?.artist, "Invalid subtitle for search result item 1")
      }
}
