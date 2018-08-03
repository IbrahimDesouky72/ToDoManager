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
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do
        {
            try context.execute(deleteRequest)
            try context.save()
            print("deleted")
            
        }
        catch
        {
            print ("There was an error")
        }
    }
    class func getAllTasks() ->[TaskAttributes]{
        
        let appDelegete = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegete.persistentContainer.viewContext
        
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Task")
        var tasks : [TaskAttributes] = [TaskAttributes]()
        
        do {
            var coreDataTasks : [Task] = [Task]()
            coreDataTasks = try managedContext.fetch(fetchRequest) as! [Task]
            print("fetch +"+String(coreDataTasks.count))
            
            
            
            for task in coreDataTasks {
                //print(movie.originalTitle)
                print(task.name!)
                let myTask : TaskAttributes = TaskAttributes()
                myTask.name = task.name!
                myTask.categoryColor = task.categoryColor!
                myTask.categoryName = task.categoryName!
                myTask.completionDate = task.completionDate!
                myTask.isCompleted = task.completed
                
                tasks.append(myTask)
            }
            
        }catch{
            print("error")
        }
        return tasks
        
    }
    
    class func addTaskToCoreData(task :TaskAttributes ) -> Bool{
        
        let appDelegete = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegete.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Task", in: managedContext)
        
        
        var result = false
        
        let coreTask = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        
        
        if(fetchRecord(name: task.name ,entityName : "Task", columnName : "name")) != true {
            coreTask.setValue(task.name, forKey: "name")
            coreTask.setValue(task.categoryColor, forKey: "categoryColor")
            coreTask.setValue(task.categoryName, forKey: "categoryName")
            coreTask.setValue(task.completionDate, forKey: "completionDate")
            coreTask.setValue(task.isCompleted, forKey: "completed")
            do {
                try managedContext.save()
                print("heree99")
                result = true
               
            }catch let error as NSError{
                print(error)
                
            }
        }else {
            print("exist")
            result = false
        }
        print(result)
        return result
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
    
    class func deleteRecord(taskName : String , entityName : String) -> Bool {
        let context = ( UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        //let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        do {
            let result = try context.fetch(deleteFetch)
            for task in result as! [Task] {
                if task.name == taskName {
                    context.delete(task)
                    try context.save()
                    
                    return true
                }
            }
            try context.save()
        } catch {
            print("Failed")
        }
        return false
        
    }
    
}
