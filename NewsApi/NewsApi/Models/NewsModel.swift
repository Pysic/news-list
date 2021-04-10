//  Created by Pietro Rischi Nunes (E) on 09/04/21.
//

import Foundation

//
//  SignUpModel.swift
//  NewsApi
//
//  Created by Pietro Rischi Nunes (E) on 08/04/21.
//

import Foundation

struct NewsModel : Codable {
    var data: [NewsDataModel]
    var pagination: NewsInfoModel
}

struct HighlightsModel : Codable {
    var data: [NewsDataModel]
}

struct NewsDataModel : Codable {
    var title: String
    var description: String
    var content: String
    var author: String
    var published_at: String
    var highlight: Bool
    var url: String
    var image_url: String
    
    var format_date: String{
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"

        if let date = dateFormatterGet.date(from: published_at) {
            return dateFormatterPrint.string(from: date)
        } else {
            return ""
        }
    }
}

struct NewsInfoModel : Codable {
    var current_page: Int
    var per_page: Int
    var total_pages: Int
    var total_items: Int
}

