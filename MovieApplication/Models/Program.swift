//
//  Program.swift
//  MovieApplication
//
//  Created by Catalina on 2/3/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import Foundation

class Program: Decodable {
    var originalName: String?
    var name: String?
    var popularity: Float?
    var originCountry: [String]
    var voteCount: Int?
    var firstAirDate: String?
    var posterPath: String?
    var id: Int
    var backdropPath: String?
    var originalLanguage: String?
    var genreIds: [Int]?
    var voteAverage: Float?
    var overview: String?
    
    private enum CodingKeys: String, CodingKey {
        // String type
        case originalName = "original_name", firstAirDate = "first_air_date", posterPath = "poster_path", backdropPath = "backdrop_path", originalLanguage = "original_language", name, overview
        // Float type
        case voteAverage = "vote_average", popularity
        // Int type
        case voteCount = "vote_count", id
        // Array type
        case originCountry = "origin_country", genreIds = "genre_ids"
    }
}
