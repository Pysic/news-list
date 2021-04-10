//
//  NewsFavoriteTableViewCell.swift
//  NewsApi
//
//  Created by Pietro Rischi Nunes (E) on 10/04/21.
//

import UIKit

class NewsFavoritesTableViewCell: UITableViewCell {

    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func renderArticle(with article: NewsCoreData){
        if(titleLabel !== nil && descLabel !== nil && newsImage !== nil){
            titleLabel.text = article.title
            descLabel.text = article.desc
            if let image = article.image as? UIImage {
                newsImage.image = image
            }
        }
    }

}
