//
//  Api.swift
//  MovieApplication
//
//  Created by Catalina on 1/31/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import Foundation

let ROOT_LINK = "https://api.themoviedb.org/3/"
let API_KEY = "?api_key=d946957b5c4e68cd9115ebea6a06c502"
let MOVIE = "movie/"
let PROGRAM = "tv/"
let PERSON = "person/"
let CREDIT = "credits"
let TOP_RATE = "top_rated"
let POPULAR = "popular"

class Api {
    static var movie = MovieApi()
    static var program = ProgramApi()
    static var person = PersonApi()
    static var general = Genaral()
}

struct AppString{

}
