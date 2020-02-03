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
    var total_results: Int?
    var total_pages: Int?
    var results: [Person]?
}
