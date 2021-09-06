//
//  CoreDataManager.swift
//  WalrusAssignment
//
//  Created by Pushpsen Airekar on 06/09/21.


import Foundation
import CoreData

protocol Persister {
    func save()
    func requestUpdatedData()
}


class PersistanceService {
    
    private init() {}
    static let shared = PersistanceService()
    
    var context : NSManagedObjectContext { return persistentContainer.viewContext }
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "WalrusAssignment")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func save() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("Saved Successfully")
            } catch {
                let error = error as NSError
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    
    func fetchArticles() -> [Article] {
        do {
            let articlesRequest = NSFetchRequest<Article>(entityName: "Article")
            let Articles = try context.fetch(articlesRequest)
            return Articles
        } catch {
            print(error)
            return []
        }
    }
}
