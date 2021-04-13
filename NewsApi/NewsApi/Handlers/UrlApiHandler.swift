//
//  UrlApiHandler.swift
//  NewsApi
//
//  Created by Pietro Rischi Nunes (E) on 13/04/21.
//

import Foundation

class UrlApiHandler{
    func getUrl(url:SIGN_URLS) -> String{
        switch url {
        case .SIGN_IN:
            return "https://mesa-news-api.herokuapp.com/v1/client/auth/signin"
        case .SIGN_UP:
            return "https://mesa-news-api.herokuapp.com/v1/client/auth/signup"
        }
    }
    func getUrl(url:NEWS_URLS) -> String{
        switch url {
        case .HIGHLIGHTS:
            return "https://mesa-news-api.herokuapp.com/v1/client/news/highlights"
        case .NEWS:
            return "https://mesa-news-api.herokuapp.com/v1/client/news?current_page=\(ControllersUtils().getNextPageNumber())"
        case .NEWS_DATE:
            return
                "https://mesa-news-api.herokuapp.com/v1/client/news?current_page=\(ControllersUtils().getNextPageNumber())&published_at=\(ControllersUtils().getPublishDate())"
        }
    }
}
