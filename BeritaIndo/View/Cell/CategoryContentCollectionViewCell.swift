//
//  CategoryContentCollectionViewCell.swift
//  BeritaIndo
//
//  Created by Agung Dwi Saputra on 20/10/23.
//

import UIKit

class CategoryContentCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CategoryContentCollectionViewCell"
    
    private var catLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 1
        return label
    }()
    
    private var capsuleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.9977579713, green: 0.1741216779, blue: 0.3346705437, alpha: 1)
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(capsuleView)
        capsuleView.addSubview(catLbl)
        setupConstraint()
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            capsuleView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5),
            capsuleView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -5),
            capsuleView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
            capsuleView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -5),
            
            catLbl.leadingAnchor.constraint(equalTo: capsuleView.leadingAnchor, constant: 15),
            catLbl.trailingAnchor.constraint(equalTo: capsuleView.trailingAnchor, constant: -15),
            catLbl.topAnchor.constraint(equalTo: capsuleView.topAnchor, constant: 10),
            catLbl.bottomAnchor.constraint(equalTo: capsuleView.bottomAnchor, constant: -10),
        ])
    }
    
    func setupData(text: String) {
        catLbl.text = text
    }
    
    func updateSelected() {
        capsuleView.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
    }
    
    func updateNotSelected() {
        capsuleView.backgroundColor = #colorLiteral(red: 0.9977579713, green: 0.1741216779, blue: 0.3346705437, alpha: 1)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
