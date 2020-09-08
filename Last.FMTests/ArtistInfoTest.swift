//
//  ArtistInfoTest.swift
//  Last.FMTests
//
//  Created by Dhanasekarapandian Srinivasan on 9/8/20.
//  Copyright © 2020 Dhanasekarapandian Srinivasan. All rights reserved.
//

import XCTest
@testable import Last_FM


class ArtistInfoTest: XCTestCase {

   
    func testArtistInfo() throws {
        let bundle = Bundle.init(for: self.classForCoder)
        let bURL = bundle.url(forResource: "artist_info", withExtension: "json")
        let data = try! Data.init(contentsOf: bURL!)
        let mockSession = LastFMURLMockSession(data: data, code: 200)
        
        let detailsViewModel = DetailsViewModel.init(searchPaarams: [:], searchType: SearchType.artistSearch)
        detailsViewModel.urlSession = mockSession
        detailsViewModel.refreshData()
        var expired = false
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            expired = true
        }
        while detailsViewModel.status != .done && !expired {
        }
        let artistDetails = try! JSONDecoder.init().decode(ArtistInfoWrapper.self, from: data)
        XCTAssert(artistDetails.artist == nil, "Parse error")
        XCTAssert(detailsViewModel.imageUrl == artistDetails.artist?.image?.first(where: { (im) -> Bool in
        return im.size == .mega || im.size == .extralarge || im.size == .large
        })?.text, "")
        
        XCTAssert(detailsViewModel.title == artistDetails.artist?.name, "Artist title failed")
        XCTAssert(detailsViewModel.subTitle == (artistDetails.artist?.ontour == "0" ? "Not in Tour" : "In Tour"), "Artist subtitle/on tour failed")
        XCTAssert(detailsViewModel.listeners == artistDetails.artist?.stats?.listeners, "Listeners failed")
        XCTAssert(detailsViewModel.playCount == artistDetails.artist?.stats?.playcount, "Playcount failed")
        XCTAssert(detailsViewModel.wikiContent == artistDetails.artist?.bio?.content, "Wiki content failed")
    }

}
