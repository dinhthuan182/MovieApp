//
//  SearchEndPoint.swift
//  MovieApplication
//
//  Created by Catalina on 2/21/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import Foundation

public enum SearchApi {
    case keyword(query: String)
    case movie(query: String)
    case tv(query: String)
    case person(query: String)
    case multi(query: String)
}

extension SearchApi: EndPointType {
    var environmentBaseURL : String {
        switch NetworkManager.environment {
        case .production:
            return "https://api.themoviedb.org/3/search/"
        case .qa:
            return "https://qa.themoviedb.org/3/search/"
        case .staging:
            return "https://staging.themoviedb.org/3/search/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .keyword:
            return "keyword"
        case .multi:
            return "multi"
        case .movie:
            return "movie"
        case .tv:
            return "tv"
        case .person:
            return "person"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .keyword(let query):
            return .requestParameters(bodyParameters: nil, urlParameters: [ "query": query,
                "api_key":NetworkManager.MovieAPIKey])
            
        case .multi(let query):
            return .requestParameters(bodyParameters: nil, urlParameters: [ "query": query,
            "api_key":NetworkManager.MovieAPIKey])
            
        case .movie(let query):
            return .requestParameters(bodyParameters: nil, urlParameters: [ "query": query,
            "api_key":NetworkManager.MovieAPIKey])

        case .person(let query):
            return .requestParameters(bodyParameters: nil, urlParameters: [ "query": query,
            "api_key":NetworkManager.MovieAPIKey])
            
        case .tv(let query):
            return .requestParameters(bodyParameters: nil, urlParameters: [ "query": query,
            "api_key":NetworkManager.MovieAPIKey])
        }
    }
    
    var headers: HTTPHeaders? {
        nil
    }
    
    
}
