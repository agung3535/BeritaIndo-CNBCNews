//
//  ViewController.swift
//  BeritaIndo
//
//  Created by Agung Dwi Saputra on 19/10/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var newsTable: UITableView!
    
    private var sectionHome = [SectionPage]()
    var vm: NewsViewmodel!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initSection()
        let service: NewsServiceProtocol = NewsService()
        vm = NewsViewmodel(service: service)
        vm.getNewsCategory()
        vm.getNews()
        title = "Hello News"
        navigationController?.navigationBar.prefersLargeTitles = true
        newsTable.register(UINib(nibName: NewsListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: NewsListTableViewCell.identifier)
        newsTable.register(UINib(nibName: CategoryTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CategoryTableViewCell.identifier)
        newsTable.register(UINib(nibName: NewsTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: NewsTableViewCell.identifier)
        newsTable.delegate = self
        newsTable.dataSource = self
        newsTable.separatorStyle = .none
        
        
        vm.newsListUpdate = { [weak self] in
            self?.newsTable.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .automatic)
        }
        
        vm.categoryList = { [weak self] in
            self?.newsTable.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        }
        
     
    }
    
    private func initSection() {
        sectionHome.append(SectionPage(section: .category))
        sectionHome.append(SectionPage(section: .newsList))

        
    }


}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionHome.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sectionHome[indexPath.row].section {
        case .category:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier, for: indexPath) as? CategoryTableViewCell else {
                return UITableViewCell()
            }
            cell.newsProtocol = self
            cell.setupCategory(data: vm.category)
            return cell
        case .newsList:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsListTableViewCell.identifier, for: indexPath) as? NewsListTableViewCell else {
                return UITableViewCell()
            }
            cell.protocolCell = self
            cell.setupNews(data: vm.news)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch sectionHome[indexPath.row].section {
        case .category:
            return 50
        default:
            let cell2 = newsTable.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier) as! NewsTableViewCell
            
            return (cell2.frame.height * CGFloat(vm.news.count))
        }
    }
   
    
}

extension ViewController: NewsListProtocol {
    func navigateTo(Id: String, data: CNBCNewsResource) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "ArticleDetail") as? ArticleDetailViewController {
            vc.data = data
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    func updateSelectedCategory(data: String) {
        if data != "all" {
            vm.getNewsByCategory(data: data)
        }else {
            vm.getNews()
        }
        
    }
    
    
}


protocol NewsListProtocol {
    func updateSelectedCategory(data: String)
    func navigateTo(Id: String, data: CNBCNewsResource)
}

