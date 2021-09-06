//
//  EventListViewController.swift
//  EventsApp
//
//  Created by Pushpsen Airekar on 05/09/21.
//

import UIKit


class ArticleList : UIViewController {
    
    var tableView: UITableView! = nil
    var safeArea: UILayoutGuide!
    var viewModel: ArticleListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationbar()
        viewModel.onUpdate = { [weak self] in
            self?.tableView.reloadData()
        }
        viewModel.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        setupNavigationbar()
    }
    
    deinit {
        print("deinit from add event UIViewController")
    }
    
    private func setupTableView() {
        self.view.backgroundColor = UIColor(named: "theme-color")
        safeArea = view.layoutMarginsGuide
        tableView = UITableView()
        self.view.addSubview(self.tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: self.safeArea.topAnchor).isActive = true
        self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = .clear
        self.tableView.tableFooterView = UIView(frame: .zero)
        tableView.setContentOffset(.init(x: 0, y: -1), animated: false)
        tableView.contentInsetAdjustmentBehavior = .never
        let articleCell  =  UINib(nibName: "ArticleCell", bundle: .main)
        tableView.register(articleCell, forCellReuseIdentifier: "ArticleCell")
    }
    
    private func setupNavigationbar(){
    self.navigationController?.navigationBar.isHidden = false
    navigationItem.leftBarButtonItem =   UIBarButtonItem(image: UIImage(systemName: "xmark"), landscapeImagePhone: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(didTapOnClose))
    navigationController?.navigationBar.tintColor = .white
    navigationController?.navigationBar.prefersLargeTitles = true
    navigationItem.title = viewModel.title
    
    let appearance = UINavigationBarAppearance()
    appearance.backgroundColor = UIColor(named: "bar-color")
    
    appearance.largeTitleTextAttributes = [
        NSAttributedString.Key.font: UIFont(name: "BudmoJiggler", size: 30) ?? UIFont.systemFont(ofSize: 30, weight: .medium), NSAttributedString.Key.foregroundColor: UIColor.white
    ]
    appearance.titleTextAttributes = [
        NSAttributedString.Key.font: UIFont(name: "BudmoJiggler", size: 20) ?? UIFont.systemFont(ofSize: 15, weight: .medium), NSAttributedString.Key.foregroundColor: UIColor.white
    ]
    self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
    self.navigationController?.navigationBar.compactAppearance = appearance
    self.navigationController?.navigationBar.standardAppearance = appearance
        
    }
    
    @objc func didTapOnClose() {
        viewModel.didTapOnClose()
    }
    
    
}

extension ArticleList: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = viewModel.cell(at: indexPath)
        switch cellViewModel {
        case .articleCell(let articleCellViewModel):
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as? ArticleCell {
                cell.update(with: articleCellViewModel)
                cell.delegate = self
                return cell
            }
        case .none: break
        }
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      //  viewModel.didSelectRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ArticleList: ArticleCellDelegate {
    
    func didSeeFullNewsPressed(url: String, title: String) {
        viewModel.didTapOnSeeFullNews(url: url, title: title)
    }
    
}
 
