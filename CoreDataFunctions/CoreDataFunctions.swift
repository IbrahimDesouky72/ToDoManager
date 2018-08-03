//
//  CoreDataFunctions.swift
//  ToDoManager
//
//  Created by Ahmed Mokhtar on 8/2/18.
//  Copyright © 2018 Ahmed Mokhtar. All rights reserved.
//

import Foundation
import CoreData
import UIKit
class CoreDataFunctions{
    
    class func getAllCategories(newAndEditTask : NewAndEditTask) -> [Category] {
        var categories = [Category]()
        let appDelegete = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegete.persistentContainer.viewContext
        
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Category")
        
        do {
            
            categories = try managedContext.fetch(fetchRequest) as! [Category]
            if categories.count > 0 {
                newAndEditTask.updateUI(categories: categories)
                print(categories.count)
            }
            
        }catch{
            print("error")
        }
        
        return categories
    }
    
    class func resetAllRecords() // entity = Your_Entity_Name
    {
        
        let context = ( UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do
        {
            try context.execute(deleteRequest)
            try context.save()
            
        }
        catch
        {
            print ("There was an error")
        }
    }
    
    class func addTaskToCoreData(task :TaskAttributes ){
        
        let appDelegete = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegete.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Task", in: managedContext)
        
        
        
        
        let coreTask = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        
        
        if(fetchRecord(name: task.name ,entityName : "Task", columnName : "name")) != true {
            coreTask.setValue(task.name, forKey: "name")
            coreTask.setValue(task.categoryColor, forKey: "categoryColor")
            coreTask.setValue(task.categoryName, forKey: "categoryName")
            coreTask.setValue(task.completionDate, forKey: "completionDate")
            do {
                try managedContext.save()
                print("heree99")
               
            }catch let error as NSError{
                print(error)
                
            }
        }else {
            print("exist")
        }
        
        
    }
    
    class func fetchRecord(name: String , entityName : String , columnName : String) -> Bool {
        let appDelegete = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegete.persistentContainer.viewContext
        
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        let myPredicate = NSPredicate(format: columnName + " = %@",name)
        fetchRequest.predicate = myPredicate
        var result : Bool = false
        
        do {
            
            let m = try managedContext.fetch(fetchRequest)
            if m.count > 0 {
                result = true
                
            }
            
        }catch{
            print("error")
        }
        return result
    }
    
}
