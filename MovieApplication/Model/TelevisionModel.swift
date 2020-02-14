//
//  TelevisionModel.swift
//  MovieApplication
//
//  Created by Catalina on 2/11/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import Foundation

struct TelevisionApiResponse {
    let page: Int
    let numberOfResults: Int
    let numberOfPages: Int
    let televisions: [Television]
}

extension TelevisionApiResponse: Decodable {
    private enum TelevisionApiResponseCodingKeys: String, CodingKey {
        case page
        case numberOfResults = "total_results"
        case numberOfPages = "total_pages"
        case televisions = "results"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: TelevisionApiResponseCodingKeys.self)
        
        page = try container.decode(Int.self, forKey: .page)
        numberOfResults = try container.decode(Int.self, forKey: .numberOfResults)
        numberOfPages = try container.decode(Int.self, forKey: .numberOfPages)
        televisions = try container.decode([Television].self, forKey: .televisions)
    }
}

struct Television {
    let id: Int
    let name: String
    let posterPath: String?
    let backdrop: String?
    let firstAirDate: String
    let originalName: String
    let genreIds: [Int]
    let popularity: Float
    let voteCount: Int
    let overview: String
}

extension Television: Decodable {
    enum TelevisionCodingKeys: String, CodingKey {
        case id
        case name
        case posterPath = "poster_path"
        case backdrop = "backdrop_path"
        case firstAirDate = "first_air_date"
        case originalName = "original_name"
        case genreIds = "genre_ids"
        case popularity
        case voteCount = "vote_count"
        case overview
    }
    
    init(from decoder: Decoder) throws {
        let televisionContainer = try decoder.container(keyedBy: TelevisionCodingKeys.self)
        id = try televisionContainer.decode(Int.self, forKey: .id)
        name = try televisionContainer.decode(String.self, forKey: .name)
        posterPath = try televisionContainer.decodeIfPresent(String.self, forKey: .posterPath)
        backdrop = try televisionContainer.decodeIfPresent(String.self, forKey: .backdrop)
        firstAirDate = try televisionContainer.decode(String.self, forKey: .firstAirDate)
        originalName = try televisionContainer.decode(String.self, forKey: .originalName)
        genreIds = try televisionContainer.decode([Int].self, forKey: .genreIds)
        popularity = try televisionContainer.decode(Float.self, forKey: .popularity)
        voteCount = try televisionContainer.decode(Int.self, forKey: .voteCount)
        overview = try televisionContainer.decode(String.self, forKey: .overview)
    }
    
    init() {
        id = -1
        name = ""
        posterPath = ""
        backdrop = ""
        firstAirDate = ""
        originalName = ""
        genreIds = [0]
        popularity = 0.0
        voteCount = 0
        overview = ""
    }
}
