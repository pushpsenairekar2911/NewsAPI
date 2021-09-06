//
//  Article+CoreDataClass.swift
//  WalrusAssignment
//
//  Created by Pushpsen Airekar on 06/09/21.
//
//

import Foundation
import CoreData

@objc(Article)
public class Article: NSManagedObject, Codable {
    
    enum CodingKeys: String, CodingKey {
        case author
        case articleDescription = "description"
        case url
        case urlToImage
        case publishedAt
        case content
    }
    
    
    required convenience public init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext as? CodingUserInfoKey,
              let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
              let entity = NSEntityDescription.entity(forEntityName: "Article", in: managedObjectContext) else {
            fatalError("Failed to decode Article")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.author = try container.decodeIfPresent(String.self, forKey: .author)
        self.articleDescription = try container.decodeIfPresent(String.self, forKey: .articleDescription)
        self.url = try container.decodeIfPresent(URL.self, forKey: .url)
        self.urlToImage = try container.decodeIfPresent(String.self, forKey: .urlToImage)
        self.publishedAt = try container.decodeIfPresent(String.self, forKey: .publishedAt)
        self.content = try container.decodeIfPresent(String.self, forKey: .content)
    }
}

extension CodingUserInfoKey {
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")!
}
