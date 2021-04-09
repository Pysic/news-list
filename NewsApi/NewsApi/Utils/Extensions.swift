//
//  Extensions.swift
//  NewsApi
//
//  Created by Pietro Rischi Nunes (E) on 08/04/21.
//

import Foundation
import UIKit

extension UITextField {
    func checkField() -> Bool {
        if (self.text ?? "").isEmpty {
            self.backgroundColor = UIColor.systemGray3
            return false
        }
        return true
    }
    
    func cleanField() {
        self.backgroundColor = UIColor.white
    }
}

extension UIViewController {

    func alertModal(title: String, message: String, onOk: @escaping () -> Void){
        let refreshAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                onOk()
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
}

extension UIView {
    public func loaderElement(indicator: UIActivityIndicatorView, show start: Bool){
        indicator.style = UIActivityIndicatorView.Style.medium
        indicator.center = self.center
        indicator.backgroundColor = UIColor.white
        self.addSubview(indicator)
        
        if(start){
            indicator.startAnimating()
        } else {
            indicator.stopAnimating()
            indicator.hidesWhenStopped = true
        }
    }
}
