//
//  ImagePickerCoordinator.swift
//  EventsApp
//
//  Created by Pushpsen Airekar on 06/09/21.
//

import Foundation
import  UIKit

final class ShowArticleCoordinator: NSObject, Coordinator {
    
    private let navigationController: UINavigationController
    private(set) var childCoordinators: [Coordinator] = []
    
    var parentCoordiator: ArticleListCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    func start() {
        let showArticle = ShowArticle()
        navigationController.present(showArticle, animated: true, completion: nil)
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

  
