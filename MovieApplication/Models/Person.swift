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
    let known_for_department: String?
    let name: String?
    let id: Int?
    let profile_path: String?
    let adult: Bool?
    //let known_for: []
    let gender: Int?
}
