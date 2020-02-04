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
    var vote_count: Int?
    var video: Bool?
    var poster_path: String?
    var id: Int?
    var adult: Bool?
    var backdrop_path: String?
    var original_language: String?
    var original_title: String?
    var genre_ids: [Int]?
    var title: String?
    var vote_average: Float?
    var overview: String?
    var release_date: String?
    //var belongs_to_collection:
    var budget: Int?
    var genres: [Genre]?
    var homepage: String?
    var imdb_id: String?
    var tagline: String?
}
