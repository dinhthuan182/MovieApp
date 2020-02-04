//
//  MovieApi.swift
//  MovieApplication
//
//  Created by Catalina on 1/31/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import Foundation
import Alamofire

class MovieApi {
    func getListMovie(onSuccess: @escaping(_ result: MovieTopRate) -> Void, onError: @escaping(_ errorMessage: String) -> Void ) {
        let urlString : String = ROOT_LINK + MOVIE + TOP_RATE + API_KEY
        AF.request(urlString, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { response in

            guard let json = response.data else { return }
    
            do {
                let result = try JSONDecoder().decode(MovieTopRate.self, from: json)
                onSuccess(result)
            } catch let err {
                onError(err as! String)
            }
        }
    }
    
    func getMovieDetail(with movieId: Int, onSuccess: @escaping(_ result: Movie) -> Void, onError: @escaping(_ errorMessage: String) -> Void ) {
        let urlString: String = ROOT_LINK + MOVIE + String(movieId) + API_KEY
        
        AF.request(urlString, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response) in
            guard let data = response.data else { return }
            do {
                let result = try JSONDecoder().decode(Movie.self, from: data)
                onSuccess(result)
            } catch let err {
                onError(err as! String)
            }
        }
    }
    
    func getMovieCredit(with movieId: Int, onSuccess: @escaping(_ result: Credit) -> Void, onError: @escaping(_ errorMessage: String) -> Void ) {
        let urlString: String = ROOT_LINK + MOVIE + String(movieId) + "/" + CREDIT + API_KEY
        print(urlString)
        AF.request(urlString, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response) in
            guard let data = response.data else { return }
            print(data)
            do {
                let result = try JSONDecoder().decode(Credit.self, from: data)
                
                onSuccess(result)
            } catch let err {
                onError(err as! String)
            }
        }
    }
}
