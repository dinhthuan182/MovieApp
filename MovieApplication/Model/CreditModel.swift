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
    let crew: [Crew]
}

extension CreditApiResponse: Decodable {
    
    private enum CreditApiResponseCodingKeys: String, CodingKey {
        case id
        case cast
        case crew
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CreditApiResponseCodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        cast = try container.decode([Cast].self, forKey: .cast)
        crew = try container.decode([Crew].self, forKey: .crew)
    }
}


struct Cast {
    let id: Int
    let character: String
    let creditId: String
    let gender: Int
    let castId: Int?
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
        castId = try castContainer.decodeIfPresent(Int.self, forKey: .castId)
        name = try castContainer.decode(String.self, forKey: .name)
        order = try castContainer.decode(Int.self, forKey: .order)
        profilePath = try castContainer.decodeIfPresent(String.self, forKey: .profilePath)
    }
}

struct Crew {
    let creditId: String
    let department: String
    let id: Int
    let name: String
    let gender: Int
    let job: String
    let profilePath: String?
}

extension Crew: Decodable {
    enum CrewCodingKeys: String, CodingKey {
        case creditId = "credit_id"
        case department
        case id
        case name
        case gender
        case job
        case profilePath = "profile_path"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CrewCodingKeys.self)
        creditId = try container.decode(String.self, forKey: .creditId)
        department = try container.decode(String.self, forKey: .department)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        gender = try container.decode(Int.self, forKey: .gender)
        job = try container.decode(String.self, forKey: .job)
        profilePath = try container.decodeIfPresent(String.self, forKey: .profilePath)
    }
}
