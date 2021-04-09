//
//  ControllersUtils.swift
//  NewsApi
//
//  Created by Pietro Rischi Nunes (E) on 08/04/21.
//

import Foundation
import UIKit

class ControllersUtils{
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
