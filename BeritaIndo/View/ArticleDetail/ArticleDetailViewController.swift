//
//  ArticleDetailViewController.swift
//  BeritaIndo
//
//  Created by Agung Dwi Saputra on 21/10/23.
//

import UIKit
import Kingfisher

class ArticleDetailViewController: UIViewController {

    @IBOutlet weak var articleTitle: UILabel!
    
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var btnSelengkapnya: UIButton!
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!

    @IBOutlet weak var barItem: UIBarButtonItem!
    var data: CNBCNewsResource?
    override func viewDidLoad() {
        super.viewDidLoad()

        barItem.title = "Kembali"
        // Do any additional setup after loading the view.
        btnSelengkapnya.layer.cornerRadius = 10
        articleTitle.text = data?.title ?? ""
        descriptionLbl.text = data?.contentSnippet ?? ""
        dateLbl.text = "Published at: \(String(describing: data?.isoDate.convertISODateToMyFormatDate(localeIdentifier: "id") ?? ""))"
        categoryLbl.text = "News"
        articleImage.contentMode = .scaleAspectFill
        articleImage.kf.setImage(with: URL(string: data?.image.large ?? ""))
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSelengkapnyaAc(_ sender: Any) {
        let url = URL(string: data?.link ?? "")
        guard let url = url else {
            return
        }
        UIApplication.shared.open(url)
    }
    
}
