//
//  TrendingEndPoint.swift
//  MovieApplication
//
//  Created by Catalina on 2/21/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import Foundation

//
//  ListEndPoint.swift
//  MovieApplication
//
//  Created by Catalina on 2/21/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import Foundation

public enum TrendingApi {
    case all(time: String)
    case movie(time: String)
    case tv(time: String)
    case person(time: String)
}

extension TrendingApi: EndPointType {
    
    var environmentBaseURL : String {
        switch NetworkManager.environment {
        case .production:
            return "https://api.themoviedb.org/3/trending/"
        case .qa:
            return "https://qa.themoviedb.org/3/trending/"
        case .staging:
            return "https://staging.themoviedb.org/3/trending/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .all(let time):
            return "all/\(time)"
        case .movie(let time):
            return "movie/\(time)"
        case .person(let time):
            return "person/\(time)"
        case .tv(let time):
            return "person/\(time)"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        return .requestParameters(bodyParameters: nil, urlParameters: ["api_key":NetworkManager.MovieAPIKey])
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}

