//
//  AllTasksTableViewController.swift
//  ToDoManager
//
//  Created by Ahmed Mokhtar on 7/31/18.
//  Copyright © 2018 Ahmed Mokhtar. All rights reserved.
//

import UIKit

class AllTasksTableViewController: UITableViewController {
    var unCompletedTasks = [TaskAttributes]()
    var completedTasks = [TaskAttributes]()

    override func viewDidLoad() {
        super.viewDidLoad()
        //CoreDataFunctions.resetAllRecords()
        let allTasks = CoreDataFunctions.getAllTasks()
        print(allTasks.count)
        unCompletedTasks = allTasks.filter {
            $0.isCompleted == false
        }
        completedTasks = allTasks.filter{
            $0.isCompleted == true
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    
    @IBAction func addNewTask(_ sender: UIBarButtonItem) {
        let newTaskController  = self.storyboard?.instantiateViewController(withIdentifier: "NewAndEditTask") as! NewAndEditTask
        
        newTaskController.isNewTask = true
        
        
        self.navigationController?.pushViewController(newTaskController, animated: true)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        switch section {
        case 0:
            return unCompletedTasks.count
        default:
            return completedTasks.count
        }
        
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "UnCompletedTasks"
        default:
            return "CompletedTasks"
        }
    }

    @IBAction func gotoSetting(_ sender: UIBarButtonItem) {
        
        let settingController  = self.storyboard?.instantiateViewController(withIdentifier: "Setting") as! Setting
        
        
        //print("hhhheeeeeeeeeeee"+String (detailController.movie.id))
        
        
        //self.navigationController?.pushViewController(detailController, animated: true)
        
        //print(self.navigationController)
        
        self.navigationController?.pushViewController(settingController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskCell

        // Configure the cell...
        switch indexPath.section {
        case 0:
            cell.colorName.text = unCompletedTasks[indexPath.row].categoryColor
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            
            
            cell.completionDate.text = dateFormatter.string(from: unCompletedTasks[indexPath.row].completionDate)
            cell.taskName.text = unCompletedTasks[indexPath.row].name
        default:
            cell.colorName.text = completedTasks[indexPath.row].categoryColor
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            
            
            cell.completionDate.text = dateFormatter.string(from: completedTasks[indexPath.row].completionDate)
            cell.taskName.text = completedTasks[indexPath.row].name
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newTaskController  = self.storyboard?.instantiateViewController(withIdentifier: "NewAndEditTask") as! NewAndEditTask
        
        newTaskController.isNewTask = false
        switch indexPath.section {
        case 0:
            newTaskController.oldTaskName = unCompletedTasks[indexPath.row].name
            newTaskController.oldTask = unCompletedTasks[indexPath.row]
        default:
            newTaskController.oldTaskName = completedTasks[indexPath.row].name
            newTaskController.oldTask = completedTasks[indexPath.row]
            newTaskController.isCompleted = true
        }
        
        
        self.navigationController?.pushViewController(newTaskController, animated: true)
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
