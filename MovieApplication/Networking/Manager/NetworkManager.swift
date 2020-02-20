//
//  NetworkManager.swift
//  MovieApplication
//
//  Created by Catalina on 2/10/20.
//  Copyright © 2020 Catalina. All rights reserved.
//

import Foundation

struct NetworkManager {
    static let environment : NetworkEnvironment = .production
    static let MovieAPIKey = "d946957b5c4e68cd9115ebea6a06c502"
    private let movieRouter = Router<MovieApi>()
    private let tvRouter = Router<TelevisionApi>()
    
    enum NetworkResponse: String {
        case success
        case authenticationError = "You need to be authenticated first."
        case badRequest = "Bad requset"
        case outdated = "The url you requested is outdated."
        case failed = "Network request failed."
        case noData = "Response returned with no data to decode."
        case unableToDecode = "We could no decode the response."
    }
    
    enum Result {
        case success
        case failure(String)
    }
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result {
        switch response.statusCode {
            case 200...299: return .success
            case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
            case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
            case 600: return .failure(NetworkResponse.outdated.rawValue)
            default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
    
    func getMoviesInTheater(page: Int, completion: @escaping (_ movieApiResponse: MovieApiResponse?, _ error: String?) -> ()) {
        movieRouter.request(.inTheater(page: page)) { (data, response, error) in
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    
                    do {
                        let apiResponse = try JSONDecoder().decode(MovieApiResponse.self, from: responseData)
                        completion(apiResponse, nil)
                    }catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    func getMovieInfomation(id: Int, completion: @escaping (_ movie: Movie?, _ error: String?) -> ()) {
        movieRouter.request(.infomation(id: id)) { (data, response, error) in
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
               let result = self.handleNetworkResponse(response)
               switch result {
               case .success:
                   guard let responseData = data else {
                       completion(nil, NetworkResponse.noData.rawValue)
                       return
                   }
                   
                   do {
                       let apiResponse = try JSONDecoder().decode(Movie.self, from: responseData)
                       completion(apiResponse, nil)
                   }catch {
                       completion(nil, NetworkResponse.unableToDecode.rawValue)
                   }
               case .failure(let networkFailureError):
                   completion(nil, networkFailureError)
               }
            }
        }
    }
    
    func getMovieCredits(id: Int, completion: @escaping (_ credit: CreditApiResponse?, _ error: String?) -> ()) {
        movieRouter.request(.credits(id: id)) { (data, response, error) in
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
               let result = self.handleNetworkResponse(response)
               switch result {
               case .success:
                   guard let responseData = data else {
                       completion(nil, NetworkResponse.noData.rawValue)
                       return
                   }
                   
                   do {
                       let apiResponse = try JSONDecoder().decode(CreditApiResponse.self, from: responseData)
                    completion(apiResponse, nil)
                   }catch {
                       completion(nil, NetworkResponse.unableToDecode.rawValue)
                   }
               case .failure(let networkFailureError):
                   completion(nil, networkFailureError)
               }
            }
        }
    }
    
    func getMovieTrailer(for id: Int, completion: @escaping (_ videoApiResponse: VideoApiResponse?, _ error: String?) -> ()) {
        movieRouter.request(.video(id: id)) { (data, response, error) in
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
               let result = self.handleNetworkResponse(response)
               switch result {
               case .success:
                   guard let responseData = data else {
                       completion(nil, NetworkResponse.noData.rawValue)
                       return
                   }
                   
                   do {
                       let apiResponse = try JSONDecoder().decode(VideoApiResponse.self, from: responseData)
                    completion(apiResponse, nil)
                   }catch {
                       completion(nil, NetworkResponse.unableToDecode.rawValue)
                   }
               case .failure(let networkFailureError):
                   completion(nil, networkFailureError)
               }
            }
        }
    }
    
    func getAiringTodayTV(page: Int, completion: @escaping (_ televisionData: TelevisionApiResponse?, _ error: String?) -> ()) {
        tvRouter.request(.airingToday(page: page)) { (data, response, error) in
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    
                    do {
                        let apiResponse = try JSONDecoder().decode(TelevisionApiResponse.self, from: responseData)
                        completion(apiResponse, nil)
                    }catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    func getFeatureds(page: Int, completion: @escaping (_ movieApiResponse: MovieApiResponse?, _ error: String?) -> ()) {
        movieRouter.request(.featured(page: page)) { (data, response, error) in
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    
                    do {
                        let apiResponse = try JSONDecoder().decode(MovieApiResponse.self, from: responseData)
                        completion(apiResponse, nil)
                    }catch {
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    func getTelevisonInfomation(id: Int, completion: @escaping (_ tv: Television?, _ error: String?) -> ()) {
        tvRouter.request(.infomation(id: id)) { (data, response, error) in
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
               let result = self.handleNetworkResponse(response)
               switch result {
               case .success:
                   guard let responseData = data else {
                       completion(nil, NetworkResponse.noData.rawValue)
                       return
                   }
                   
                   do {
                       let apiResponse = try JSONDecoder().decode(Television.self, from: responseData)
                       completion(apiResponse, nil)
                   }catch {
                       completion(nil, NetworkResponse.unableToDecode.rawValue)
                   }
               case .failure(let networkFailureError):
                   completion(nil, networkFailureError)
               }
            }
        }
    }
    
    func getTelevisionCredits(id: Int, completion: @escaping (_ credit: CreditApiResponse?, _ error: String?) -> ()) {
        tvRouter.request(.credits(id: id)) { (data, response, error) in
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
               let result = self.handleNetworkResponse(response)
               switch result {
               case .success:
                   guard let responseData = data else {
                       completion(nil, NetworkResponse.noData.rawValue)
                       return
                   }
                   
                   do {
                       let apiResponse = try JSONDecoder().decode(CreditApiResponse.self, from: responseData)
                    completion(apiResponse, nil)
                   }catch {
                       completion(nil, NetworkResponse.unableToDecode.rawValue)
                   }
               case .failure(let networkFailureError):
                   completion(nil, networkFailureError)
               }
            }
        }
    }
    
    func getTelevisonTrailer(for id: Int, completion: @escaping (_ videoApiResponse: VideoApiResponse?, _ error: String?) -> ()) {
        tvRouter.request(.video(id: id)) { (data, response, error) in
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
               let result = self.handleNetworkResponse(response)
               switch result {
               case .success:
                   guard let responseData = data else {
                       completion(nil, NetworkResponse.noData.rawValue)
                       return
                   }
                   
                   do {
                       let apiResponse = try JSONDecoder().decode(VideoApiResponse.self, from: responseData)
                    completion(apiResponse, nil)
                   }catch {
                       completion(nil, NetworkResponse.unableToDecode.rawValue)
                   }
               case .failure(let networkFailureError):
                   completion(nil, networkFailureError)
               }
            }
        }
    }
}
