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
            AF.request(urlString, method: .get, parameters:nil, encoding: JSONEncoding.default).responseJSON { response in

                guard let json = response.data else { return }
        
                do {
                    let result = try JSONDecoder().decode(MovieTopRate.self, from: json)
                    onSuccess(result)
                } catch let err {
                    onError(err as! String)
                }
            }
    }
}
