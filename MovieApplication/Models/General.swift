//
//  General.swift
//  MovieApplication
//
//  Created by Catalina on 2/3/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import UIKit
import Alamofire

let IMAGE_ROOT_LINK = "https://image.tmdb.org/t/p/w500/"

class Genaral {
    func getImageLink(_ name: String) -> String {
        return IMAGE_ROOT_LINK + name
    }
}
