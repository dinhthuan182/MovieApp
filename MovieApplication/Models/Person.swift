//
//  Person.swift
//  MovieApplication
//
//  Created by Catalina on 2/3/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import Foundation

struct Person {
    let popularity: Float?
    let knownForDepartment: String?
    let name: String?
    let id: Int
    let profilePath: String?
    let adult: Bool?
    let gender: Int?
    let creditId: String?
    let birthday: String?
    let biography: String?
    let homepage: String?
    let placeOfBirth: String?
}
extension Person: Decodable {
    enum PersonCodingKeys: String, CodingKey {
        // Float type
        case popularity
        // String type
        case knownForDepartment = "known_for_department", profilePath = "profile_path", creditId = "credit_id", name, biography, homepage, birthday, placeOfBirth = "place_of_birth"
        // Int type
        case id, gender
        // Bool type
        case adult
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PersonCodingKeys.self)
        
        popularity = try container.decodeIfPresent(Float.self, forKey: .popularity)
        knownForDepartment = try container.decodeIfPresent(String.self, forKey: .knownForDepartment)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        id = try container.decode(Int.self, forKey: .id)
        profilePath = try container.decodeIfPresent(String.self, forKey: .profilePath)
        adult = try container.decodeIfPresent(Bool.self, forKey: .adult)
        gender = try container.decodeIfPresent(Int.self, forKey: .gender)
        creditId = try container.decodeIfPresent(String.self, forKey: .creditId)
        birthday = try container.decodeIfPresent(String.self, forKey: .birthday)
        biography = try container.decodeIfPresent(String.self, forKey: .biography)
        homepage = try container.decodeIfPresent(String.self, forKey: .homepage)
        placeOfBirth = try container.decodeIfPresent(String.self, forKey: .placeOfBirth)
    }
}
