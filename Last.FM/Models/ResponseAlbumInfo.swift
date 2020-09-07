//
//  ResponseAlbumInfo.swift
//  Last.FM
//
//  Created by Dhanasekarapandian Srinivasan on 9/6/20.
//  Copyright © 2020 Dhanasekarapandian Srinivasan. All rights reserved.
//

import Foundation

// MARK: - AlbumInfo
struct AlbumInfoWrapper: Codable {
    let album: AlbumDetails
}

// MARK: - Album
struct AlbumDetails: Codable {
    let name: String?
    let artist: String?
    let mbid: String?
    let url: String?
    let image: [Image]?
    let listeners, playcount: String?
    let tracks: TracksWrapper?
    let tags: TagsWrapper?
    let wiki: Wiki?
}


// MARK: - Tags
struct TagsWrapper: Codable {
    let tag: [TagLink]
}

// MARK: - Tag
struct TagLink: Codable {
    let name: String
    let url: String
}

// MARK: - Tracks
struct TracksWrapper: Codable {
    let track: [TrackDetail]
}

// MARK: - Track
struct TrackDetail: Codable {
    let name: String
    let url: String
    let duration: String
    let attr: AttrRank
    let streamable: Streamable
    let artist: ArtistClass

    enum CodingKeys: String, CodingKey {
        case name, url, duration
        case attr = "@attr"
        case streamable, artist
    }
}

// MARK: - ArtistClass
struct ArtistClass: Codable {
    let name: String
    let mbid: String
    let url: String
}

// MARK: - Attr
struct AttrRank: Codable {
    let rank: String
}

// MARK: - Streamable
struct Streamable: Codable {
    let text, fulltrack: String

    enum CodingKeys: String, CodingKey {
        case text = "#text"
        case fulltrack
    }
}

// MARK: - Wiki
struct Wiki: Codable {
    let published, summary, content: String
}

