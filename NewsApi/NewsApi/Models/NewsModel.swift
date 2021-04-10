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

struct NewsDataModel : Codable {
    var title: String
    var description: String
    var content: String
    var author: String
    var published_at: String
    var highlight: Bool
    var url: String
    var image_url: String
}

struct NewsInfoModel : Codable {
    var current_page: Int
    var per_page: Int
    var total_pages: Int
    var total_items: Int
}

