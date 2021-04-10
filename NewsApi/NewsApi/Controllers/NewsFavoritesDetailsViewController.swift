//
//  NewsFavoritesDetailsViewController.swift
//  NewsApi
//
//  Created by Pietro Rischi Nunes (E) on 10/04/21.
//

import UIKit

class NewsFavoritesDetailsViewController: UIViewController {
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var contentLabel: UITextView!
    @IBAction func unfavoriteButton(_ sender: Any) {
        self.alertArticleDelete(index: index ?? 0)
    }
    
    private func alertArticleDelete(index: Int){
        self.alertModalWithOption(title: "Remover Notícia.", message: "Tem certeza que deseja remover essa notícia?", onOk: {
            CoreDataHandler.shared.deleteByIndex(index: index)
            self.navigationController?.popViewController(animated: true)
        }, onCancel: {
            return
        })
    }
    
    var article: NewsCoreData!
    var index: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = article.title
        authorLabel.text = article.author
        dateLabel.text = article.date
        contentLabel.text = article.content
        if let image = article.image as? UIImage {
            newsImage.image = image
        }
    
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
