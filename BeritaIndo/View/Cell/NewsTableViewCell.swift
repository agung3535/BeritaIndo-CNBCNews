//
//  NewsTableViewCell.swift
//  BeritaIndo
//
//  Created by Agung Dwi Saputra on 20/10/23.
//

import UIKit
import Kingfisher


class NewsTableViewCell: UITableViewCell {
    
    static let identifier = "NewsTableViewCell"

    @IBOutlet weak var newsSnippet: UILabel!
    @IBOutlet weak var newsDate: UILabel!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        newsImage.layer.cornerRadius = 10
        newsImage.contentMode = .scaleAspectFill
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupNews(data: CNBCNewsResource) {
        newsDate.text = data.isoDate.convertISODateToMyFormatDate(localeIdentifier: "id")
        newsSnippet.text = data.contentSnippet
        newsTitle.text = data.title
        let imgUrl = URL(string: data.image.small)
        let proccessor = DownsamplingImageProcessor(size: newsImage.bounds.size)
        newsImage.kf.setImage(
            with: imgUrl,
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .processor(proccessor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
    
}
