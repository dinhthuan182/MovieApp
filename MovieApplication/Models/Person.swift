//
//  Person.swift
//  MovieApplication
//
//  Created by Catalina on 2/3/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import Foundation

class Person: Decodable {
    let popularity: Float?
    let knownForDepartment: String?
    let name: String?
    let id: Int
    let profilePath: String?
    let adult: Bool?
    //let known_for: []
    let gender: Int?
    let creditId: String?
    let birthday: String?
    let biography: String?
    let homepage: String?
    let placeOfBirth: String?
    
    private enum CodingKeys: String, CodingKey {
        // Float type
        case popularity
        // String type
        case knownForDepartment = "known_for_department", profilePath = "profile_path", creditId = "credit_id", name, biography, homepage, birthday, placeOfBirth = "place_of_birth"
        // Int type
        case id, gender
        // Bool type
        case adult
    }
}
