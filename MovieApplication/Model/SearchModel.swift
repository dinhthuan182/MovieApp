//
//  SearchModel.swift
//  MovieApplication
//
//  Created by Catalina on 2/21/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import Foundation

struct SearchApiResponse {
    let page: Int
    let results: [Search]
    let totalPages: Int
    let totalResults: Int
}

extension SearchApiResponse: Decodable {
    enum SearchApiResponseCodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SearchApiResponseCodingKeys.self)
        
        page = try container.decode(Int.self, forKey: .page)
        results = try container.decode([Search].self, forKey: .results)
        totalPages = try container.decode(Int.self, forKey: .totalPages)
        totalResults = try container.decode(Int.self, forKey: .totalResults)
    }
}

struct Search {
    let name: String
    let id: Int
}

extension Search: Decodable {
    enum SearchCodingKeys: String, CodingKey {
        case name
        case id
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SearchCodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        id = try container.decode(Int.self, forKey: .id)
    }
}
