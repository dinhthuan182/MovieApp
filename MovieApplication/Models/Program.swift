//
//  Program.swift
//  MovieApplication
//
//  Created by Catalina on 2/3/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import Foundation

class Program: Decodable {
    let originalName: String?
    let name: String?
    let popularity: Float?
    let originCountry: [String]
    let voteCount: Int?
    let firstAirDate: String?
    let posterPath: String?
    let id: Int
    let backdropPath: String?
    let originalLanguage: String?
    let genreIds: [Int]?
    let voteAverage: Float?
    let overview: String?
    let createdBy: [Person]?
    
    private enum CodingKeys: String, CodingKey {
        // String type
        case originalName = "original_name", firstAirDate = "first_air_date", posterPath = "poster_path", backdropPath = "backdrop_path", originalLanguage = "original_language", name, overview
        // Float type
        case voteAverage = "vote_average", popularity
        // Int type
        case voteCount = "vote_count", id
        // Array type
        case originCountry = "origin_country", genreIds = "genre_ids", createdBy = "created_by"
    }
}
