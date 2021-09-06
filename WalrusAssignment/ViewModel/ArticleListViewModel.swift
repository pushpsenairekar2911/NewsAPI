//
//  EventListviewModel.swift
//  EventsApp
//
//  Created by Pushpsen Airekar on 05/09/21.
//

import Foundation

final class ArticleListViewModel: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    func start() {
        
    }
    
    
    enum Cell {
        case articleCell(ArticleCellViewModel)
    }
    
    let title = "WHAT'S THE BUZZ?"
    var onUpdate: () -> Void = {}
    
    var coordinator: ArticleListCoordinator?
    var parentCoordiator: AnimatorSplashScreenCoordinator?
    private(set) var cells: [Cell] = []
    private let persistanceService = PersistanceService.shared
    
    func viewDidLoad() {
        configureCellsWithLocalData()
        configureCellsWithNewData()
    }
    
    func configureCellsWithLocalData() {
        // Local Data
        let localArticals = persistanceService.fetchArticles()
        var localCells = [Cell]()
        for article in localArticals {
            let cell = ArticleCellViewModel(title: article.title ?? "", author: article.author ?? "", content: article.content ?? "", image: article.urlToImage ?? "", url: article.url?.absoluteString ?? "", updatedAt: article.publishedAt ?? "", onCellUpdate: self.onUpdate)
            localCells.append(.articleCell(cell))
        }
        self.cells = localCells
        self.onUpdate()
    }
    
    func configureCellsWithNewData() {
        Walrus.fetchTopHeadLines { results in
            switch results {
            case .success(let articles):
                var newCells = [Cell]()
                for article in articles {

                    let cell = ArticleCellViewModel(title: article.title ?? "", author: article.author ?? "", content: article.content ?? "", image: article.urlToImage ?? "", url: article.url?.absoluteString ?? "", updatedAt: article.publishedAt ?? "", onCellUpdate: self.onUpdate)
                    newCells.append(.articleCell(cell))
                }
                self.cells = newCells
                self.onUpdate()
            case .failure(_):
                break
            }
        }
    }

    func didTapOnClose() {
        parentCoordiator?.childDidFinish(self)
    }
    
    func numberOfRows() -> Int {
        return cells.count
    }
    
    func cell(at indexPath: IndexPath) -> Cell? {
        return cells[safe: indexPath.row] ?? nil
    }
    
    func didSelectRow(at indexPath: IndexPath) {
    
        switch cells[indexPath.row] {
        case .articleCell(let articleCellViewModel):
            coordinator?.launchFullArticle(title: articleCellViewModel.title, url: articleCellViewModel.url)
        }
    }
    
    func didTapOnSeeFullNews(url: String, title: String) {
        coordinator?.launchFullArticle(title: title, url: url)
    }
}
