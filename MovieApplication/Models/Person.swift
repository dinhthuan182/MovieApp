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
    
    private enum CodingKeys: String, CodingKey {
        // Float type
        case popularity
        // String type
        case knownForDepartment = "known_for_department", profilePath = "profile_path", name
        // Int type
        case id, gender
        // Bool type
        case adult
    }
}
