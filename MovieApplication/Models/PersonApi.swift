//
//  PersonApi.swift
//  MovieApplication
//
//  Created by Catalina on 2/3/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import Foundation
import Alamofire

class PersonApi {
    func getListPerson(onSuccess: @escaping(_ result: PersonPopular) -> Void, onError: @escaping(_ errorMessage: String) -> Void ) {
        let urlString : String = ROOT_LINK + PERSON + POPULAR + API_KEY
        AF.request(urlString, method: .get, parameters:nil, encoding: JSONEncoding.default).responseJSON { response in

            guard let json = response.data else { return }
    
            do {
                let result = try JSONDecoder().decode(PersonPopular.self, from: json)
                onSuccess(result)
            } catch let err {
                onError(err as! String)
            }
        }
    }
}
