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
    var total_results: Int?
    var total_pages: Int?
    var results: [Movie]?
}

class ProgramTopRate: Decodable {
    var page: Int?
    var total_results: Int?
    var total_pages: Int?
    var results: [Program]?
}
