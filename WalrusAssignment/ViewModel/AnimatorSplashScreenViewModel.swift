//
//  EventListviewModel.swift
//  EventsApp
//
//  Created by Pushpsen Airekar on 05/09/21.
//

import Foundation

final class AnimatorSplashScreenViewModel {
  
    var onUpdate: () -> Void = {}
    var coordinator: AnimatorSplashScreenCoordinator?

    init() {}

    func didTapOnSkip() {
        coordinator?.launchArticleList()
    }
    
}
