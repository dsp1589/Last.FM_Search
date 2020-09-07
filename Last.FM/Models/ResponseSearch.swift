//
//  ResponseSearch.swift
//  Last.FM
//
//  Created by Dhanasekarapandian Srinivasan on 9/5/20.
//  Copyright © 2020 Dhanasekarapandian Srinivasan. All rights reserved.
//

import Foundation

// MARK: - ResponseSearch
struct ResponseSearch: Codable {
    let results: Results
}

// MARK: - Results
struct Results: Codable {
    let opensearchQuery: OpensearchQuery
    let opensearchTotalResults, opensearchStartIndex, opensearchItemsPerPage: String
    let artistmatches: Artistmatches?
    let albummatches: Albummatches?
    let trackmatches: Trackmatches?
    
    let attr: Attr

    enum CodingKeys: String, CodingKey {
        case opensearchQuery = "opensearch:Query"
        case opensearchTotalResults = "opensearch:totalResults"
        case opensearchStartIndex = "opensearch:startIndex"
        case opensearchItemsPerPage = "opensearch:itemsPerPage"
        case artistmatches
        case albummatches
        case trackmatches
        case attr = "@attr"
    }
}

// MARK: - Artistmatches
struct Artistmatches: Codable {
    let artist: [Artist]
}

// MARK: - Albummatches
struct Albummatches: Codable {
    let album: [Album]
}

// MARK: - Trackmatches
struct Trackmatches: Codable {
    let track: [Track]
}

// Mark: - Track
struct Track: Codable {
    let name: String?
    let artist: String?
    let url: String?
    let streamable: String?
    let listeners: String?
    let image: [Image]?
    let mbid: String?
}

// MARK: - Album

struct Album: Codable {
    let name,mbid: String?
    let artist: String
    let url: String
    let streamable: String?
    let image: [Image]
}

// MARK: - Artist
struct Artist: Codable {
    let name, mbid: String
    let listeners: String?
    let url: String
    let streamable: String?
    let image: [Image]?
}

// MARK: - Image
struct Image: Codable {
    let text: String
    let size: Size

    enum CodingKeys: String, CodingKey {
        case text = "#text"
        case size
    }
}

enum Size: String, Codable {
    case extralarge = "extralarge"
    case large = "large"
    case medium = "medium"
    case mega = "mega"
    case small = "small"
    case EMPTY = ""
}

// MARK: - Attr
struct Attr: Codable {
    let attrFor: String?

    enum CodingKeys: String, CodingKey {
        case attrFor = "for"
    }
}

// MARK: - OpensearchQuery
struct OpensearchQuery: Codable {
    let text, role, startPage: String
    let searchTerms: String?

    enum CodingKeys: String, CodingKey {
        case text = "#text"
        case role, searchTerms, startPage
    }
}

