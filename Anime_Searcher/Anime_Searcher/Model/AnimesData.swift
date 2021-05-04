//
//  Anime.swift
//  Anime_Searcher
//
//  Created by Jonathan Alajoan Rocha on 30/04/21.
//

import Foundation

struct AnimeRoot: Codable {
    var data: [AnimeData]
}

struct AnimeData: Codable {
    var id: String
    var type: String
    var attributes: AnimeAttributes
}

struct AnimeAttributes: Codable {
    var slug: String?
    var synopsis: String?
    var canonicalTitle: String?
    var titles: AnimeTitles
    var averageRating: String?
    var ageRatingGuide: String?
    var status: String?
    var posterImage: AnimePosterImage?
    var coverImage: AnimeCoverImage?
    var episodeCount: Int?
    var episodeLength: Int?
    var totalLength: Int
}

struct AnimePosterImage: Codable {
    var tiny: String?
    var small: String?
    var medium: String?
}


struct AnimeCoverImage: Codable {
    var tiny: String?
    var small: String?
    var medium: String?
}
struct AnimeTitles: Codable {
    var ja_jp: String?
    var en_jp: String?
}

