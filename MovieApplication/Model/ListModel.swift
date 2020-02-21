//
//  ListModel.swift
//  MovieApplication
//
//  Created by Catalina on 2/21/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import Foundation

struct ListApiResponse {
    let createdBy: String
    let description: String
    let favoriteCount: Int
    let id: String
    let items: [Movie]
    let itemCount: Int
    let name: String
    let posterPath: String
}

extension ListApiResponse: Decodable {
    enum ListApiResponseCodingKeys: String, CodingKey {
        case createdBy = "created_by"
        case description
        case favoriteCount = "favorite_count"
        case id
        case items
        case itemCount = "item_count"
        case name
        case posterPath = "poster_path"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ListApiResponseCodingKeys.self)
        
        createdBy = try container.decode(String.self, forKey: .createdBy)
        description = try container.decode(String.self, forKey: .description)
        favoriteCount = try container.decode(Int.self, forKey: .favoriteCount)
        id = try container.decode(String.self, forKey: .id)
        items = try container.decode([Movie].self, forKey: .items)
        itemCount = try container.decode(Int.self, forKey: .itemCount)
        name = try container.decode(String.self, forKey: .name)
        posterPath = try container.decode(String.self, forKey: .posterPath)
    }
}
