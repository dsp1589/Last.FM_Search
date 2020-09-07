//
//  ResponseArtistInfo.swift
//  Last.FM
//
//  Created by Dhanasekarapandian Srinivasan on 9/7/20.
//  Copyright © 2020 Dhanasekarapandian Srinivasan. All rights reserved.
//

import Foundation

// MARK: - ArtistInfoWrapper
struct ArtistInfoWrapper: Codable {
    let artist: ArtistDetails?
}

// MARK: - Artist
struct ArtistDetails: Codable {
    let name: String?
    let url: String?
    let image: [Image]?
    let streamable, ontour: String?
    let stats: Stats?
    let tags: Tags?
    let bio: Bio?
}

// MARK: - Bio
struct Bio: Codable {
    let links: Links?
    let published, summary, content: String?
}

// MARK: - Links
struct Links: Codable {
    let link: Link?
}

// MARK: - Link
struct Link: Codable {
    let text, rel: String?
    let href: String?

    enum CodingKeys: String, CodingKey {
        case text = "#text"
        case rel, href
    }
}

// MARK: - Stats
struct Stats: Codable {
    let listeners, playcount: String?
}

// MARK: - Tags
struct Tags: Codable {
    let tag: [Tag]?
}

// MARK: - Tag
struct Tag: Codable {
    let name: String?
    let url: String?
}
