//
//  Cast.swift
//  MovieApplication
//
//  Created by Catalina on 2/4/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import Foundation

class Cast: Decodable {
    let castId: Int
    let character: String?
    let creditId: String
    let gender: Int?
    let id: Int
    let name: String?
    let order: Int
    let profilePath: String?
    
    private enum CodingKeys: String, CodingKey {
        // Int type
        case castId = "cast_id", gender, id, order
        // String type
        case profilePath = "profile_path", creditId = "credit_id", character, name
    }
}
