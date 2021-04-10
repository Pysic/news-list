//
//  NewsDetailsViewController.swift
//  NewsApi
//
//  Created by Pietro Rischi Nunes (E) on 09/04/21.
//

import UIKit

class NewsFeedDetailsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var publishDateLabel: UILabel!
    @IBOutlet weak var contentText: UITextView!
    @IBOutlet weak var favButton: UIButton!
    @IBAction func favoriteButton(_ sender: UIButton) {
        article.favorite ? CoreDataHandler.shared.deleteNewsByArticle(article: article) : CoreDataHandler.shared.insertNews(article: article)
        sender.renderFavoriteButton(article: article)
    }
    
    var article: NewsDataModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.numberOfLines = 0
        
        favButton.renderFavoriteButton(article: article)
        titleLabel.text = article.title
        contentText.text = article.content
        authorLabel.text = article.author
        publishDateLabel.text = article.format_date
        newsImage.kf.setImage(with: URL(string: article.image_url))
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
