//
//  TopRate.swift
//  MovieApplication
//
//  Created by Catalina on 1/31/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import Foundation

class MovieTopRate: Decodable {
    var page: Int?
    var totalResults: Int?
    var totalPages: Int?
    var results: [Movie]?
    
    private enum CodingKeys: String, CodingKey {
        case totalResults = "total_results", totalPages = "total_pages", page
        case results
    }
}

class ProgramTopRate: Decodable {
    var page: Int?
    var totalResults: Int?
    var totalPages: Int?
    var results: [Program]?
    
    private enum CodingKeys: String, CodingKey {
        case totalResults = "total_results", totalPages = "total_pages", page
        case results
    }
}
