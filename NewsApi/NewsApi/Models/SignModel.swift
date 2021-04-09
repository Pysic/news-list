//
//  SignUpModel.swift
//  NewsApi
//
//  Created by Pietro Rischi Nunes (E) on 08/04/21.
//

import Foundation

struct SignModel : Codable {
    var token: String
}

struct SignErrorModel : Codable {
    var errors: [SignErrorCodeModel]
}

struct SignErrorCodeModel : Codable {
    var code: String
}
