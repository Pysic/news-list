//
//  ControllersUtils.swift
//  NewsApi
//
//  Created by Pietro Rischi Nunes (E) on 08/04/21.
//

import Foundation
import UIKit

struct ControllersUtils{
    
    private static var token: String = ""
    private static var pageNumber: Int = 1
    private static var publishDate: String = ""
    
    public func getToken() -> String{
        return ControllersUtils.token
    }
    
    public func setToken(token: String) {
        ControllersUtils.token = token
    }
    
    public func getNextPageNumber() -> Int{
        let currentNumber = ControllersUtils.pageNumber
        ControllersUtils.pageNumber = ControllersUtils.pageNumber + 1
        return currentNumber
    }
    
    public func resetPageNumber(){
        ControllersUtils.pageNumber = 1
    }
    
    public func getPublishDate() -> String{
        return ControllersUtils.publishDate
    }
    
    public func setPublishDate(date: String){
        ControllersUtils.publishDate = date
    }
    
    func checkFields(of fields: [UITextField]) -> Bool{
        var status: Bool = true
        for field in fields {
            if !field.checkField(){
                status=false
            }
        }
        return status
    }
}
