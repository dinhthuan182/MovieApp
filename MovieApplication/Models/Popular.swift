//
//  Popular.swift
//  MovieApplication
//
//  Created by Catalina on 2/3/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import Foundation

class PersonPopular: Decodable {
    var page: Int?
    var totalResults: Int?
    var totalPages: Int?
    var results: [Person]?
    
    private enum CodingKeys: String, CodingKey {
        case totalResults = "total_results", totalPages = "total_pages", page
        case results
    }
}
