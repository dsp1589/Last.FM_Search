//
//  AlbumInfoTest.swift
//  Last.FMTests
//
//  Created by Dhanasekarapandian Srinivasan on 9/8/20.
//  Copyright © 2020 Dhanasekarapandian Srinivasan. All rights reserved.
//

import XCTest
@testable import Last_FM


class AlbumInfoTest: XCTestCase {

   func testAlbumInfo() throws {
       let bundle = Bundle.init(for: self.classForCoder)
       let bURL = bundle.url(forResource: "album_info", withExtension: "json")
       let data = try! Data.init(contentsOf: bURL!)
       let mockSession = LastFMURLMockSession(data: data, code: 200)
       
       let detailsViewModel = DetailsViewModel.init(searchPaarams: [:], searchType: SearchType.albumSearch)
       detailsViewModel.urlSession = mockSession
       detailsViewModel.refreshData()
       var expired = false
       DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
           expired = true
       }
       while detailsViewModel.status != .done && !expired {
       }
       let albumInfo = try! JSONDecoder.init().decode(AlbumInfoWrapper.self, from: data)
    
    XCTAssert(detailsViewModel.imageUrl == albumInfo.album.image?.first(where: { (im) -> Bool in
       return im.size == .mega || im.size == .extralarge || im.size == .large
       })?.text, "")
       
    XCTAssert(detailsViewModel.title == albumInfo.album.name, "Album title failed")
    XCTAssert(detailsViewModel.subTitle == albumInfo.album.artist, "Album tour failed")
    XCTAssert(detailsViewModel.listeners == albumInfo.album.listeners, "Listeners failed")
    XCTAssert(detailsViewModel.playCount == albumInfo.album.playcount, "Playcount failed")
    XCTAssert(detailsViewModel.wikiContent == albumInfo.album.wiki?.content, "Wiki content failed")
   }

}
