//
//  NewsListTableViewCell.swift
//  BeritaIndo
//
//  Created by Agung Dwi Saputra on 21/10/23.
//

import UIKit

class NewsListTableViewCell: UITableViewCell {
    
    static let identifier = "NewsListTableViewCell"

    @IBOutlet weak var newsTable: UITableView!
    
    var protocolCell: NewsListProtocol?
    
    private var newsResource = [CNBCNewsResource]()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        newsTable.register(UINib(nibName: NewsTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: NewsTableViewCell.identifier)
        newsTable.register(UINib(nibName: LoaderNewsTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: LoaderNewsTableViewCell.identifier)
        newsTable.delegate = self
        newsTable.dataSource = self
        newsTable.isScrollEnabled = false
        newsTable.separatorStyle = .none
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupNews(data: [CNBCNewsResource]) {
        self.newsResource = data
        self.newsTable.reloadData()
    }

    
}

extension NewsListTableViewCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if newsResource.isEmpty {
            return 1
        }else {
            return newsResource.count
        }
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if newsResource.isEmpty {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LoaderNewsTableViewCell.identifier, for: indexPath) as? LoaderNewsTableViewCell else {
                return UITableViewCell()
            }
            cell.startLoad()
            return cell
        }else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else {
                return UITableViewCell()
            }
            
            cell.setupNews(data: newsResource[indexPath.row])
            return cell
        }
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        protocolCell?.navigateTo(Id: "ArticleDetail", data: newsResource[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if newsResource.isEmpty {
            return 100
        }else {
            return UITableView.automaticDimension
        }
        
    }
    
}


