//
//  TitleSubTitleViewModel.swift
//  EventsApp
//
//  Created by Pushpsen Airekar on 05/09/21.
//

import Foundation
import UIKit

final class ArticleCellViewModel {
    
    private(set) var author: String
    private(set) var title: String
    private(set) var content: String
    private(set) var image: String
    private(set) var url: String
    private(set) var updatedAt: String
   
    var parentCoordiator: ArticleListCoordinator?
    
    private(set) var onCellUpdate: () -> Void = {}
    
    init(title:String, author: String, content: String, image: String, url: String,updatedAt: String,onCellUpdate: @escaping () -> Void) {
        self.title = title
        self.author = author
        self.content = content
        self.image = image
        self.url = url
        self.updatedAt = updatedAt
        self.onCellUpdate = onCellUpdate
    }
    
    func update(title: String) {
        self.title = title
       onCellUpdate()
    }
    
    func update(author: String) {
        self.author = author
        onCellUpdate()
    }
    
    func update(content: String) {
        self.content = content
        onCellUpdate()
    }

    func update(image: String) {
        self.image = image
       onCellUpdate()
    }

}
