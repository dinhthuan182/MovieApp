//
//  TrendingModel.swift
//  MovieApplication
//
//  Created by Catalina on 2/21/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import Foundation

struct TrendingApiResponse {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
}

extension TrendingApiResponse: Decodable {
    private enum TrendingApiResponseCodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: TrendingApiResponseCodingKeys.self)
        
        page = try container.decode(Int.self, forKey: .page)
        results = try container.decode([Movie].self, forKey: .results)
        totalPages = try container.decode(Int.self, forKey: .totalPages)
        totalResults = try container.decode(Int.self, forKey: .totalResults)
    }
}
