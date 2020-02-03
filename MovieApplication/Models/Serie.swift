//
//  Serie.swift
//  MovieApplication
//
//  Created by Catalina on 2/3/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import Foundation

class Serie: Decodable {
    let popularity: Float?
    let vote_count: Int?
    let video: Bool?
    let poster_path: String?
    let id: Int?
    let adult: Bool?
    let backdrop_path: String?
    let original_language: String?
    let original_title: String?
    let genre_ids: [Int]?
    let title: String?
    let vote_average: Float?
    let overview: String?
    let release_date: String?
}
