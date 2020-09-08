//
//  TrackInfoTest.swift
//  Last.FMTests
//
//  Created by Dhanasekarapandian Srinivasan on 9/8/20.
//  Copyright © 2020 Dhanasekarapandian Srinivasan. All rights reserved.
//

import XCTest
@testable import Last_FM

class TrackInfoTest: XCTestCase {

  
    func testTrackInfo() throws {
       let bundle = Bundle.init(for: self.classForCoder)
          let bURL = bundle.url(forResource: "track_info", withExtension: "json")
          let data = try! Data.init(contentsOf: bURL!)
          let mockSession = LastFMURLMockSession(data: data, code: 200)
          
        let detailsViewModel = DetailsViewModel.init(searchPaarams: [:], searchType: SearchType.trackSearch)
          detailsViewModel.urlSession = mockSession
          detailsViewModel.refreshData()
          var expired = false
          DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
              expired = true
          }
          while detailsViewModel.status != .done && !expired {
          }
          let trackInfo = try! JSONDecoder.init().decode(TrackInfoWrapper.self, from: data)
       
        XCTAssert(detailsViewModel.imageUrl == trackInfo.track?.album?.image.first(where: { (im) -> Bool in
        return im.size == .mega || im.size == .extralarge || im.size == .large
        })?.text, "")
          
        XCTAssert(detailsViewModel.title == trackInfo.track?.name, "Track title failed")
        XCTAssert(detailsViewModel.subTitle == trackInfo.track?.album?.artist, "Album tour failed")
        XCTAssert(detailsViewModel.listeners == trackInfo.track?.listeners, "Listeners failed")
        XCTAssert(detailsViewModel.playCount == trackInfo.track?.playcount, "Playcount failed")
       XCTAssert(detailsViewModel.wikiContent == trackInfo.track?.wiki?.content, "Wiki content failed")
    }

}
