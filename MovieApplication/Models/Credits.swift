//
//  Credits.swift
//  MovieApplication
//
//  Created by Catalina on 2/4/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import Foundation

class Credit: Decodable {
    let id: Int
    let cast: [Cast]
    
    private enum CodingKeys: String, CodingKey {
        case id
        case cast
    }
}
