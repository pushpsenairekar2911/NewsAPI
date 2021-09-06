//
//  ImagePickerCoordinator.swift
//  EventsApp
//
//  Created by Pushpsen Airekar on 06/09/21.
//

import Foundation
import  UIKit

final class AnimatorSplashScreenCoordinator: NSObject, Coordinator {
    
    private let navigationController: UINavigationController
    private(set) var childCoordinators: [Coordinator] = []
    
    var parentCoordiator: ArticleListCoordinator?
    
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    func start() {
        let animatorSpalshScreen: AnimatorSpalshScreen = .instantiate()
        let animatorSplashScreenViewModel = AnimatorSplashScreenViewModel()
        animatorSplashScreenViewModel.coordinator = self
        animatorSpalshScreen.viewModel = animatorSplashScreenViewModel
        navigationController.setViewControllers([animatorSpalshScreen], animated: false)
    }
    
    func launchArticleList() {
        let articleListCoordinator = ArticleListCoordinator(navigationController: navigationController)
        childCoordinators.append(articleListCoordinator)
        articleListCoordinator.parentCoordinator = self
        articleListCoordinator.start()
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

  
