//
//  Program.swift
//  MovieApplication
//
//  Created by Catalina on 2/3/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import Foundation

class Program: Decodable {
    var original_name: String?
    var name: String?
    var popularity: Float?
    var origin_country: [String]
    var vote_count: Int?
    var first_air_date: String?
    var poster_path: String?
    var id: Int?
    var backdrop_path: String?
    var original_language: String?
    var genre_ids: [Int]?
    var vote_average: Float?
    var overview: String?
}
