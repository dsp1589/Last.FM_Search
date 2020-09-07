//
//  Params.swift
//  Last.FM
//
//  Created by Dhanasekarapandian Srinivasan on 9/5/20.
//  Copyright © 2020 Dhanasekarapandian Srinivasan. All rights reserved.
//

import Foundation



enum SearchMethod: String, CaseIterable  {
    case trackSearch = "track.search"
    case artistSearch = "artist.search"
    case albumSearch = "album.search"
}

enum SearchType: String, CaseIterable  {
    case trackSearch = "track"
    case artistSearch = "artist"
    case albumSearch = "album"
}

enum GetInfo: String, CaseIterable  {
    case artistInfo = "artist.getInfo"
    case trackInfo = "track.getInfo"
    case albumInfo = "album.getInfo"
}

enum QParams: String, CaseIterable {
    case json = "json"
    case format = "format"
    case apiKey = "api_key"
    case method = "method"
    case artist = "artist"
    case album = "album"
    case track = "track"
}
