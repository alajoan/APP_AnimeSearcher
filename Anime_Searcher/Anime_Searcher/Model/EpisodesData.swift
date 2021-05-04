//
//  Anime.swift
//  Anime_Searcher
//
//  Created by Jonathan Alajoan Rocha on 30/04/21.
//

import Foundation

struct EpisodeRoot: Codable {
    var data: [EpisodeData]
}

struct EpisodeData: Codable {
    var id: String?
    var type: String?
    var attributes: EpisodeAttributes?
}

struct EpisodeAttributes: Codable {
    var synopsis: String?
    var canonicalTitle: String?
    var seasonNumber: Int
    var number: Int
    var thumbnail: EpisodeThumbnail?
}

struct EpisodeThumbnail: Codable {
    var original: String?
}

struct EpisodeLinks: Codable {
    var related: String?
}
