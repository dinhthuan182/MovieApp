//
//  ListEndPoint.swift
//  MovieApplication
//
//  Created by Catalina on 2/21/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import Foundation

public enum ListApi {
    case detail(id: Int)
    case check(id: Int)
}

extension ListApi: EndPointType {
    
    var environmentBaseURL : String {
        switch NetworkManager.environment {
        case .production:
            return "https://api.themoviedb.org/3/list/"
        case .qa:
            return "https://qa.themoviedb.org/3/list/"
        case .staging:
            return "https://staging.themoviedb.org/3/list/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
            case .check(let id):
                return "\(id)/item_status"
            case .detail(let id):
                return "\(id)"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .detail:
            return .requestParameters(bodyParameters: nil, urlParameters: ["api_key":NetworkManager.MovieAPIKey])
        default:
            return .requestParameters(bodyParameters: nil, urlParameters: ["api_key":NetworkManager.MovieAPIKey])
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}

