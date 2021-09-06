//
//  EventListviewModel.swift
//  EventsApp
//
//  Created by Pushpsen Airekar on 05/09/21.
//

import Foundation

final class ShowArticleViewModel {
    
    let title = "Title"
    var onUpdate: () -> Void = {}
    var coordinator: ShowArticleCoordinator?

    init() {}

}
