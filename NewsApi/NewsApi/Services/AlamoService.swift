//
//  AlamoService.swift
//  NewsApi
//
//  Created by Pietro Rischi Nunes (E) on 07/04/21.
//

import Foundation
import Alamofire
//

enum HttpError {
    case errorData
    case errorResponseCode
}

enum SIGN_URLS: String {
    case SIGN_IN = "https://mesa-news-api.herokuapp.com/v1/client/auth/signin"
    case SIGN_UP = "https://mesa-news-api.herokuapp.com/v1/client/auth/signup"
}

enum NEWS_URLS: String {
    case NEWS = "https://mesa-news-api.herokuapp.com/v1/client/news?current_page="
    case HIGHLIGHTS = "https://mesa-news-api.herokuapp.com/v1/client/news/highlights"
}

class AlamoService{
    func signApi<T: Decodable>(url endpoint:SIGN_URLS, parameters: [String: String], completion: @escaping (SignModel) -> Void, onApiError: @escaping (T) -> Void, onError: @escaping (HttpError) -> Void){
        AF.request(endpoint.rawValue, method: .post,  parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
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
    
    func newsApi<T: Decodable>(url:NEWS_URLS, headers: HTTPHeaders, completion: @escaping (T) -> Void, onError: @escaping (HttpError) -> Void){
        let endpoint = url == .NEWS ? url.rawValue + String(ControllersUtils().getNextPageNumber()) : url.rawValue
        AF.request(endpoint, method: .get, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    do {
                        let json = try JSONDecoder().decode(T.self, from: response.data!)
                        completion(json)
                    } catch {
                        onError(.errorData)
                    }
                case .failure(let error):
                    onError(.errorResponseCode)
                    print(error)
                }
            }
    }
}
