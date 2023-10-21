//
//  LoaderNewsTableViewCell.swift
//  BeritaIndo
//
//  Created by Agung Dwi Saputra on 21/10/23.
//

import UIKit

class LoaderNewsTableViewCell: UITableViewCell {

    static let identifier = "LoaderNewsTableViewCell"
    
    @IBOutlet weak var loadingBar: UIActivityIndicatorView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func startLoad() {
        loadingBar.startAnimating()
    }
    
}
