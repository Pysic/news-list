//
//  NewsFeedTableViewCell.swift
//  NewsApi
//
//  Created by Pietro Rischi Nunes (E) on 09/04/21.
//

import UIKit
import Kingfisher

class NewsFeedTableViewCell: UITableViewCell {

    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.numberOfLines = 2
        descLabel.numberOfLines = 2
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func renderArticle(with article: NewsDataModel){
        if(titleLabel !== nil && newsImage !== nil && descLabel !== nil){
            titleLabel.text = article.title
            descLabel.text = article.description
            newsImage.kf.setImage(with: URL(string: article.image_url))
        }
    }

}
