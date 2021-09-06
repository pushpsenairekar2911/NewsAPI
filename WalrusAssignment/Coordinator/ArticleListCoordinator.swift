//
//  ArticleListCoordinator.swift
//  ArticlesApp
//
//  Created by Pushpsen Airekar on 05/09/21.
//

import Foundation
import UIKit


final class ArticleListCoordinator: Coordinator {

    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    var parentCoordinator: AnimatorSplashScreenCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let articleList: ArticleList = .instantiate()
        let ArticleListViewModel = ArticleListViewModel()
        ArticleListViewModel.coordinator = self
        articleList.viewModel = ArticleListViewModel
        navigationController.setViewControllers([articleList], animated: false)
    }
    
    
    func launchFullArticle(title: String, url: String) {
        let showArticleCoordinator = ShowArticleCoordinator(navigationController: navigationController)
        childCoordinators.append(showArticleCoordinator)
        showArticleCoordinator.parentCoordiator = self
        let showArticle: ShowArticle = .instantiate()
        showArticle.title = title
        showArticle.url = url
        navigationController.pushViewController(showArticle, animated: true)
    }
    
    func childDidFinish(_ childCoordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { coordinator -> Bool
            in
            return childCoordinator === coordinator 
        }) {
            childCoordinators.remove(at: index)
        }
    }
    
}
