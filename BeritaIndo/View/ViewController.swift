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
            self?.newsTable.reloadSections(IndexSet(integer: 1), with: .automatic)
        }
        
        vm.categoryList = { [weak self] in
            self?.newsTable.reloadSections(IndexSet(integer: 0), with: .automatic)
        }
        
     
    }
    
    private func initSection() {
        sectionHome.append(SectionPage(section: .category))
        sectionHome.append(SectionPage(section: .newsList))

        
    }


}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionHome.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sectionHome[section].section {

        case .category:
            return vm.category.count > 0 ? 1 : 0
        case .newsList:
            return vm.news.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch sectionHome[indexPath.section].section {
        case .category:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier, for: indexPath) as? CategoryTableViewCell else {
                return UITableViewCell()
            }
            cell.newsProtocol = self
            cell.setupCategory(data: vm.category)
            return cell
        case .newsList:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else {
                return UITableViewCell()
            }
            cell.setupNews(data: vm.news[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateTo(Id: "ArticleDetail" , data: vm.news[indexPath.row])
    }
   
    
}

extension ViewController: NewsListProtocol {
    func navigateTo(Id: String, data: CNBCNewsResource) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: Id) as? ArticleDetailViewController {
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

