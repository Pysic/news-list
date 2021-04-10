//
//  CoreDataHandler.swift
//  marvel
//
//  Created by Pietro Rischi Nunes (E) on 22/03/21.
//

import Foundation
import UIKit
import CoreData

class CoreDataHandler: UIViewController {
    
    var newsData: NewsCoreData!
    var news: [NewsCoreData] = []
    static let shared = CoreDataHandler()
    
    func insertNews(article: NewsDataModel){
        newsData = NewsCoreData(context: coreDataContext)
        newsData.id = article.id
        newsData.title = article.title
        newsData.author = article.author
        newsData.desc = article.description
        newsData.date = article.format_date
        newsData.content = article.content
        newsData.url = article.url
        
        let imageUrl:URL = URL(string: article.image_url)!
        let imageData:NSData = NSData(contentsOf: imageUrl)!
        let image = UIImage(data: imageData as Data)
        newsData.image = image

        do{
            try coreDataContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }

    func deleteNewsByArticle(article: NewsDataModel) {
        let fetchRequest: NSFetchRequest<NewsCoreData> = NewsCoreData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@", article.id)

        var results: [NewsCoreData] = []

        do {
            results = try coreDataContext.fetch(fetchRequest)
            coreDataContext.delete(results[0])
            try coreDataContext.save()
        }
        catch {
            print(error.localizedDescription)
        }
    }

    func deleteByIndex(index: Int) {
        let article = news[index]
        coreDataContext.delete(article)

        do {
            try coreDataContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }

    func loadNews() {
        let fetchRequest: NSFetchRequest<NewsCoreData> = NewsCoreData.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        do{
            news = try coreDataContext.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
    }

    func checkSaved(id: String) -> Bool{
        let fetchRequest: NSFetchRequest<NewsCoreData> = NewsCoreData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@", id)

        var results: [NewsCoreData] = []

        do {
            results = try coreDataContext.fetch(fetchRequest)
        }
        catch {
            print(error.localizedDescription)
        }

        return results.count > 0
    }
}

