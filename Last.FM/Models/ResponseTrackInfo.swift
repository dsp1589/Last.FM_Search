//
//  ResponseTrackInfo.swift
//  Last.FM
//
//  Created by Dhanasekarapandian Srinivasan on 9/7/20.
//  Copyright © 2020 Dhanasekarapandian Srinivasan. All rights reserved.
//

import Foundation

// MARK: - TrackInfoWrapper
struct TrackInfoWrapper: Codable {
    let track: TrackInfo?
}

// MARK: - Track
struct TrackInfo: Codable {
    let name, mbid: String?
    let url: String?
    let duration: String?
    let streamable: StreamableTrack?
    let listeners, playcount: String?
    let artist: Artist?
    let album: Album?
    let toptags: Toptags?
    let wiki: TWiki?
}

// MARK: - Streamable
struct StreamableTrack: Codable {
    let text, fulltrack: String?

    enum CodingKeys: String, CodingKey {
        case text = "#text"
        case fulltrack
    }
}

// MARK: - Toptags
struct Toptags: Codable {
    let tag: [Tag]?
}

// MARK: - Wiki
struct TWiki: Codable {
    let published, summary, content: String?
}
