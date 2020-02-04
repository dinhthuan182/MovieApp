//
//  Movie.swift
//  MovieApplication
//
//  Created by Catalina on 1/31/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import Foundation

class Movie: Decodable {
    var popularity: Float?
    var voteCount: Int?
    var video: Bool?
    var posterPath: String?
    var id: Int
    var adult: Bool?
    var backdropPath: String?
    var originalLanguage: String?
    var originalTitle: String?
    var genreIds: [Int]?
    var title: String?
    var voteAverage: Float?
    var overview: String?
    var releaseDate: String?
    var budget: Int?
    var genres: [Genre]?
    var homepage: String?
    var imdbId: String?
    var tagline: String?
    
    private enum CodingKeys: String, CodingKey {
        // Float type
        case popularity, voteAverage = "vote_average"
        // Int type
        case voteCount = "vote_count", id, budget
        // Bool type
        case video, adult
        // String type
        case posterPath = "poster_path", backdropPath = "backdrop_path", originalLanguage = "original_language", originalTitle = "original_title", title, overview, homepage, imdbId = "imdb_id", tagline
        // Another type
        case genreIds = "genre_ids", genres
        case releaseDate = "release_date"
        
    }
}
