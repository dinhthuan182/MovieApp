//
//  TelevisionEndPoint.swift
//  MovieApplication
//
//  Created by Catalina on 2/11/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import Foundation

public enum TelevisionApi {
    case recommended(id: Int)
    case popular(page: Int)
    case airingToday(page: Int)
    case onTheAir(page: Int)
    case infomation(id: Int)
    case topRated(page: Int)
    case credits(id: Int)
    case video(id: Int)
}

extension TelevisionApi: EndPointType {
    var environmentBaseURL : String {
        switch NetworkManager.environment {
        case .production:
            return "https://api.themoviedb.org/3/tv/"
        case .qa:
            return "https://qa.themoviedb.org/3/tv/"
        case .staging:
            return "https://staging.themoviedb.org/3/tv/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .recommended(let id):
            return "\(id)/recommendations"
        case .popular:
            return "popular"
        case .airingToday:
            return "airing_today"
        case .onTheAir:
            return "on_the_air"
        case .infomation(let id):
            return "\(id)"
        case .topRated:
            return "top_rated"
        case .credits(let id):
            return "\(id)/credits"
        case .video(let id):
            return "\(id)/videos"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .airingToday(let page):
            return .requestParameters(bodyParameters: nil,
                                      urlParameters: ["page":page,
                                                      "api_key":NetworkManager.MovieAPIKey])
        case .onTheAir(let page):
            return .requestParameters(bodyParameters: nil,
                                  urlParameters: ["page":page,
                                                  "api_key":NetworkManager.MovieAPIKey])
        case .infomation, .credits, .video:
            return .requestParameters(bodyParameters: nil, urlParameters: ["api_key":NetworkManager.MovieAPIKey])
            
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
