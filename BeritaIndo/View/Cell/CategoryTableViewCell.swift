//
//  CategoryTableViewCell.swift
//  BeritaIndo
//
//  Created by Agung Dwi Saputra on 20/10/23.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    static let identifier = "CategoryTableViewCell"
    
    private var selectedCat: Int = 0
    
    private var category = [String]()

    var newsProtocol: NewsListProtocol?

    @IBOutlet weak var categoryCollection: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        categoryCollection.delegate = self
        categoryCollection.dataSource = self
        categoryCollection.register(CategoryContentCollectionViewCell.self, forCellWithReuseIdentifier: CategoryContentCollectionViewCell.identifier)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCategory(data: [String]) {
        category = data
        categoryCollection.reloadData()
    }
}

extension CategoryTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryContentCollectionViewCell.identifier, for: indexPath) as? CategoryContentCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.setupData(text: category[indexPath.row])
        if selectedCat == indexPath.row {
            cell.updateSelected()
        }else {
            cell.updateNotSelected()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.contentScaleFactor, height: collectionView.frame.height / 1)
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCat = indexPath.row
        collectionView.reloadData()
        newsProtocol?.updateSelectedCategory(data: category[indexPath.row])
    }
    
    
}
