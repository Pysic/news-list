//
//  Extensions.swift
//  NewsApi
//
//  Created by Pietro Rischi Nunes (E) on 08/04/21.
//

import Foundation
import CoreData
import UIKit

extension String {

    var length: Int {
        return count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}

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
    var coreDataContext: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func alertModal(title: String, message: String, onOk: @escaping () -> Void){
        let refreshAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                onOk()
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }
    
    func alertModalWithOption(title: String, message: String, onOk: @escaping () -> Void, onCancel: @escaping () -> Void){
        let refreshAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                onOk()
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                onCancel()
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

extension UIButton {
    func renderFavoriteButton (article: NewsDataModel) {
        let favoriteImage = article.favorite ? "star.fill" : "star"
        let image = UIImage(systemName: favoriteImage) as UIImage?
        self.setBackgroundImage(image, for: .normal)
    }
}
