//
//  AlamoService.swift
//  NewsApi
//
//  Created by Pietro Rischi Nunes (E) on 07/04/21.
//

import Foundation
import Alamofire
//
//let headers = ["Authorization" : "Bearer ",
//               "Content-Type": "application/json"]
//

enum HttpError {
    case errorData
    case errorResponseCode
}

enum URLS_API: String {
    case SIGN_IN = "https://mesa-news-api.herokuapp.com/v1/client/auth/signin"
    case SIGN_UP = "https://mesa-news-api.herokuapp.com/v1/client/auth/signup"
}

class AlamoService{
    
    func signApi<T: Decodable>(url endpoint:URLS_API, parameters: [String: String], completion: @escaping (SignModel) -> Void, onApiError: @escaping (T) -> Void, onError: @escaping (HttpError) -> Void){
        AF.request(endpoint.rawValue, method: .post,  parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    print("value: \(value)")
                    do {
                        let json = try JSONDecoder().decode(SignModel.self, from: response.data!)
                        completion(json)
                    } catch {
                        do {
                            let json = try JSONDecoder().decode(T.self, from: response.data!)
                            onApiError(json)
                        } catch {
                            onError(.errorData)
                        }
                    }
                case .failure(let error):
                    onError(.errorResponseCode)
                    print(error)
                }
            }
    }
}
