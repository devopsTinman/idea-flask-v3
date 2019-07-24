//
//  DataService.swift
//  Idea Flask
//
//  Created by Allbee, Eamon on 7/21/19.
//  Copyright © 2019 Allbee, Eamon. All rights reserved.
//

import Foundation
import CoreData
import UIKit
class DataService {
    
    static let instance = DataService()
    //let appDelegate = UIApplication.shared.delegate as? AppDelegate
    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getIdeaCount() -> Int {
        var recordCount = 0

        let fetchRequest: NSFetchRequest<Ideas> = Ideas.fetchRequest()
        recordCount = try! managedContext.count(for: fetchRequest)
        return recordCount
    }
    
    func getAllIdeas() -> [Idea] {
        var ideaList = [Idea]()

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Ideas")
        var currentIdea: Idea
        var ideaTag: String = ""
        var ideaNotes: String = ""
        var ideaID: String = ""
        var ideaCategory: String = ""
        var ideaUser: String = ""
        var ideaDate: Date = Date()
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                ideaCategory = data.value(forKey: "ideaCategory") as? String ?? ""
                ideaTag = data.value(forKey: "ideaTagline") as? String ?? ""
                ideaNotes = data.value(forKey: "ideaNotes") as? String ?? ""
                ideaID = data.value(forKey: "ideaID") as? String ?? ""
                ideaUser = data.value(forKey: "user") as? String ?? ""
                ideaDate = data.value(forKey: "dateAdded") as? Date ?? Date()
                currentIdea = Idea(ideaCategory: ideaCategory, ideaNotes: ideaNotes, ideaTagline: ideaTag, user: ideaUser, ideaID: ideaID, dateAdded: ideaDate)
                ideaList.append(currentIdea)
                print(ideaTag)
            }
        } catch {
            print("Failed to retrieve")
        }
        return ideaList
    }
    
    func saveIdea(idea: Idea) {

        let ideaEntity = NSEntityDescription.entity(forEntityName: "Ideas", in: managedContext)!
        let newIdea = NSManagedObject(entity: ideaEntity, insertInto: managedContext)
        newIdea.setValue(idea.ideaCategory, forKey: "ideaCategory")
        newIdea.setValue(idea.ideaTagline, forKey: "ideaTagline")
        newIdea.setValue(idea.ideaNotes, forKey: "ideaNotes")
        newIdea.setValue(idea.user, forKey: "user")
        newIdea.setValue(idea.ideaID, forKey: "ideaID")
        newIdea.setValue(idea.dateAdded, forKey: "dateAdded")
        
        do {
            try managedContext.save()
            print("success")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    func deleteIdea(idea: Idea) {

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Ideas")
        fetchRequest.predicate = NSPredicate(format: "ideaID=%@", idea.ideaID)
        
        do {
            
            let test = try managedContext.fetch(fetchRequest)
            let objectToDelete = test[0] as! NSManagedObject
            managedContext.delete(objectToDelete)
            
            do {
                try managedContext.save()
                print("delete success")
            }
            catch
            {
                print(error)
            }
            
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func searchIdeas(searchText: String)-> [Idea] {
        var ideaList = [Idea]()

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Ideas")
        fetchRequest.predicate = NSPredicate(format: "ideaNotes CONTAINS[cd] %@", searchText)
      
        let sortDescriptor = NSSortDescriptor(key: "ideaTagline", ascending: true)
        
        fetchRequest.sortDescriptors = [sortDescriptor]

        var currentIdea: Idea
        var ideaTag: String = ""
        var ideaNotes: String = ""
        var ideaID: String = ""
        var ideaCategory: String = ""
        var ideaUser: String = ""
        var ideaDate: Date = Date()
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result as! [NSManagedObject] {
                ideaCategory = data.value(forKey: "ideaCategory") as? String ?? ""
                ideaTag = data.value(forKey: "ideaTagline") as? String ?? ""
                ideaNotes = data.value(forKey: "ideaNotes") as? String ?? ""
                ideaID = data.value(forKey: "ideaID") as? String ?? ""
                ideaUser = data.value(forKey: "user") as? String ?? ""
                ideaDate = data.value(forKey: "dateAdded") as? Date ?? Date()
                currentIdea = Idea(ideaCategory: ideaCategory, ideaNotes: ideaNotes, ideaTagline: ideaTag, user: ideaUser, ideaID: ideaID, dateAdded: ideaDate)
                ideaList.append(currentIdea)
                print(ideaTag)
            }
        } catch {
            print("Failed to retrieve")
        }
        
        return ideaList
        
    }
    
}
