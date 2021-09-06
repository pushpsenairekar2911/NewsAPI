//
//  Article+CoreDataProperties.swift
//  WalrusAssignment
//
//  Created by Pushpsen Airekar on 06/09/21.
//
//

import Foundation
import CoreData


extension Article {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Article> {
        return NSFetchRequest<Article>(entityName: "Article")
    }

    @NSManaged public var title: String?
    @NSManaged public var id: String
    @NSManaged public var author: String?
    @NSManaged public var articleDescription: String?
    @NSManaged public var url: URL?
    @NSManaged public var urlToImage: String?
    @NSManaged public var publishedAt: String?
    @NSManaged public var content: String?
  
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(author, forKey: .author)
        try container.encode(articleDescription, forKey: .articleDescription)
        try container.encode(url, forKey: .url)
        try container.encode(urlToImage, forKey: .urlToImage)
        try container.encode(publishedAt, forKey: .publishedAt)
        try container.encode(content, forKey: .content)
    }
}

extension Article : Identifiable {

}
