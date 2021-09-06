//
//  AppCoordinator.swift
//  ArticlesApp
//
//  Created by Pushpsen Airekar on 05/09/21.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var  childCoordinators: [Coordinator] { get }
    func start()
}


final class AppCoordinator: Coordinator {
    
    private(set) var childCoordinators: [Coordinator] = []
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
     
    func start() {
        let navigationController = UINavigationController()
        let animatorSplashScreenCoordinator = AnimatorSplashScreenCoordinator(navigationController: navigationController)
        childCoordinators.append(animatorSplashScreenCoordinator)
        animatorSplashScreenCoordinator.start()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }

}

