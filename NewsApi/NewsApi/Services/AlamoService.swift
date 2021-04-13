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
    case SIGN_IN 
    case SIGN_UP 
}

enum NEWS_URLS: String {
    case NEWS
    case NEWS_DATE
    case HIGHLIGHTS 
}

class AlamoService{
    func signApi<T: Decodable>(url:SIGN_URLS, parameters: [String: String], completion: @escaping (SignModel) -> Void, onApiError: @escaping (T) -> Void, onError: @escaping (HttpError) -> Void){
        let endpoint = UrlApiHandler().getUrl(url: url)
        AF.request(endpoint, method: .post,  parameters: parameters, encoding: JSONEncoding.default)
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
        let endpoint = UrlApiHandler().getUrl(url: url)
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
