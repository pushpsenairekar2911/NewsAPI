//
//  Walrus.swift
//  WalrusAssignment
//
//  Created by Pushpsen Airekar on 06/09/21.
//

import Foundation

class Walrus  {
    
    private init() {}
    
    let shared = Walrus()
    static var persistance = PersistanceService.shared
    
    static var apiKey: String = "faddacf5746347f4b728864395da29af"
    
    typealias result = (_ result: Result<[Article], Error>) ->Void
    
    @nonobjc static func fetchTopHeadLines(completionHandler: @escaping result) {
        do {
            let url = URL(string: "https://newsapi.org/v2/top-headlines?country=in&apiKey=\(apiKey)")
            if let url = url {
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                let task = URLSession.shared.dataTask(with: request, completionHandler: {
                    (data, response, error) in
                    
                    if let error = error
                    {
                        completionHandler(.failure(error))
                        
                    }
                    
                    DispatchQueue.main.async { // Correct
                        guard let responseData = data else {
                            print("Error: did not receive data")
                            return
                        }
                        if let result = String(data: responseData, encoding: .utf8) {
                            
                            do {
                                guard let jsonDictionary = result.convertToDictionary(), let jsonArray = jsonDictionary["articles"] as? [[String:Any]] else { return }
                               
                                let articles:[Article] = jsonArray.compactMap { 
                                    
                                    guard let author = $0["author"] as? String,
                                          let title = $0["title"] as? String,
                                          let description = $0["description"] as? String,
                                          let url = $0["url"] as? String,
                                          let urlToImage = $0["urlToImage"] as? String,
                                          let publishedAt = $0["publishedAt"] as? String,
                                          let content = $0["content"] as? String,
                                          let source = $0["source"] as? [String:Any]
                                    else { return nil }
                                    
                                    let article = Article(context: persistance.context)
                                    article.author = author
                                    article.title = title
                                    article.articleDescription = description
                                    article.url = URL(string: url)
                                    article.urlToImage = urlToImage
                                    article.publishedAt = publishedAt
                                    article.id = source["id"] as? String ?? ""
                                    //                                        article.name = source["name"] as? String
                                    article.content = content
                                    return article
                                }
                                persistance.save()
//                                let sortedArticles = articles.sorted {
//                                    var isSorted = false
//                                    if let first = $0.author, let second = $1.author {
//                                        isSorted = first < second
//                                    }
//                                    return isSorted
//                                }
                                completionHandler(.success(articles))
                            }
                            catch {
                                completionHandler(.failure(error))
                            }
                        }
                    }
                })
                task.resume()
            }
        } catch {}
    }
}
