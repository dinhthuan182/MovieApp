//
//  MovieEndPoint.swift
//  MovieApplication
//
//  Created by Catalina on 2/10/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import Foundation

enum NetworkEnvironment {
    case qa
    case production
    case staging
}

public enum MovieApi {
    case recommended(id: Int)
    case popular(page: Int)
    case inTheater(page: Int)
    case featured(page: Int)
    case infomation(id: Int)
    case video(id: Int)
    case credits(id: Int)
}

extension MovieApi: EndPointType {
    var environmentBaseURL : String {
        switch NetworkManager.environment {
        case .production:
            return "https://api.themoviedb.org/3/"
        case .qa:
            return "https://qa.themoviedb.org/3/"
        case .staging:
            return "https://staging.themoviedb.org/3/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .recommended(let id):
            return "movie/\(id)/recommendations"
        case .popular:
            return "movie/popular"
        case .inTheater:
            return "movie/now_playing"
        case .featured:
            return "trending/movie/day"
        case .infomation(let id):
            return "movie/\(id)"
        case .video(let id):
            return "movie/\(id)/videos"
        case .credits(let id):
            return "movie/\(id)/credits"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .inTheater(let page):
            return .requestParameters(bodyParameters: nil,
                                      urlParameters: ["page":page,
                                                      "api_key":NetworkManager.MovieAPIKey])
        case .featured(let page):
            return .requestParameters(bodyParameters: nil,
                                      urlParameters: ["page":page,
                                                      "api_key":NetworkManager.MovieAPIKey])
        case .infomation:
            return .requestParameters(bodyParameters: nil, urlParameters: ["api_key":NetworkManager.MovieAPIKey])
            
        case .credits:
            return .requestParameters(bodyParameters: nil, urlParameters: ["api_key":NetworkManager.MovieAPIKey])
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
