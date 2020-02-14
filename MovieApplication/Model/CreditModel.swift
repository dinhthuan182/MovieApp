//
//  CreditModel.swift
//  MovieApplication
//
//  Created by Catalina on 2/14/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import Foundation

struct CreditApiResponse {
    let id: Int
    let cast: [Cast]
}

extension CreditApiResponse: Decodable {
    
    private enum CreditApiResponseCodingKeys: String, CodingKey {
        case id
        case cast
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CreditApiResponseCodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        cast = try container.decode([Cast].self, forKey: .cast)
    }
}


struct Cast {
    let id: Int
    let character: String
    let creditId: String
    let gender: Int
    let castId: Int
    let name: String
    let order: Int
    let profilePath: String?
}

extension Cast: Decodable {
    
    enum CastCodingKeys: String, CodingKey {
        case id
        case character
        case creditId = "credit_id"
        case gender
        case castId = "cast_id"
        case name
        case order
        case profilePath = "profile_path"
    }
    
    init(from decoder: Decoder) throws {
        let castContainer = try decoder.container(keyedBy: CastCodingKeys.self)
        
        id = try castContainer.decode(Int.self, forKey: .id)
        character = try castContainer.decode(String.self, forKey: .character)
        creditId = try castContainer.decode(String.self, forKey: .creditId)
        gender = try castContainer.decode(Int.self, forKey: .gender)
        castId = try castContainer.decode(Int.self, forKey: .castId)
        name = try castContainer.decode(String.self, forKey: .name)
        order = try castContainer.decode(Int.self, forKey: .order)
        profilePath = try castContainer.decodeIfPresent(String.self, forKey: .profilePath)
    }
}
