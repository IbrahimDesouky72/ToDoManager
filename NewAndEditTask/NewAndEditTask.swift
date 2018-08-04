//
//  NewAndEditTask.swift
//  ToDoManager
//
//  Created by Ahmed Mokhtar on 8/2/18.
//  Copyright © 2018 Ahmed Mokhtar. All rights reserved.
//

import UIKit

class NewAndEditTask: UIViewController {
    
    @IBOutlet weak var errorLabel: UILabel!
    var categories = [Category]()
    private var datepicker = UIDatePicker()
    var selectedCategory = -1
    var isNewTask = true
    var isCategorySelected = false
    var isDateSelected = false
    var oldTaskName = ""
    var isCompleted = false
    var oldTask = TaskAttributes()
    @IBOutlet weak var taskName: UITextField!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var categoryTableView: UITableView!
    @IBOutlet weak var completionDate: UITextField!
    var tapGesture : UITapGestureRecognizer?
    
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // CoreDataFunctions.resetAllRecords()
        categories = CoreDataFunctions.getAllCategories(newAndEditTask: self)
        print(categories.count)
        categoryTableView.isHidden = true
        
        datepicker.datePickerMode = .date
        
        datepicker.addTarget(self, action: #selector(NewAndEditTask.dateChanged(datePicker:)), for: .valueChanged)
         tapGesture = UITapGestureRecognizer(target: self, action: #selector(NewAndEditTask.viewTapped(gestureRecognizer:)))
        tapGesture?.delegate = self
        view.addGestureRecognizer(tapGesture!)
        completionDate.inputView = datepicker
        if isNewTask {
            deleteButton.isHidden = true
            editButton.isHidden = true
        }else {
            self.navigationItem.rightBarButtonItem = nil
            taskName.text = oldTask.name
            categoryButton.setTitle(oldTask.categoryName + "," + oldTask.categoryColor, for: .normal)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            completionDate.text = dateFormatter.string(from: oldTask.completionDate)
            isCategorySelected = true
            isDateSelected = true
            
        }
        if isCompleted {
            deleteButton.isHidden = true
            editButton.isHidden = true
            //self.navigationItem.rightBarButtonItem = nil
            
            self.navigationItem.rightBarButtonItem = nil
            taskName.text = oldTask.name
            categoryButton.setTitle(oldTask.categoryName + "," + oldTask.categoryColor, for: .normal)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            completionDate.text = dateFormatter.string(from: oldTask.completionDate)
        }
        errorLabel.isHidden = true
        
        // Do any additional setup after loading the view.
        
        
    }
    
    @IBAction func categoryButtonPressed(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3){
            self.categoryTableView.isHidden = !self.categoryTableView.isHidden
        }
        
    }
    @objc func viewTapped(gestureRecognizer : UIGestureRecognizer){
        view.endEditing(true)
    }
    @objc func dateChanged(datePicker : UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        completionDate.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
        isDateSelected = true
        
    }

    func updateUI(categories : [Category])  {
        self.categories = categories
        
       
    }
    
    
    @IBAction func editButtonPressed(_ sender: UIButton) {
      if self.taskName.text != "" {
//            if CoreDataFunctions.deleteRecord(taskName: oldTaskName, entityName: Utilities.task) == true{
//                print("inside edit")
//                addToCoreData()
//            }
            let editedTask = TaskAttributes()
            editedTask.name = taskName.text!
            let category = getCategory()
            editedTask.categoryName = category[0]
            editedTask.categoryColor = category[1]
            editedTask.isCompleted = oldTask.isCompleted
            editedTask.completionDate = convertStringToDate(stringDate: completionDate.text!)
        if CoreDataFunctions.editTaskRecord(task: editedTask, oldName: oldTaskName){
            oldTaskName = editedTask.name
        }
        
        }
        
        
    }
    func convertStringToDate(stringDate : String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        return dateFormatter.date(from: stringDate)!
    }
    
    func getCategory() -> [String] {
        return (categoryButton.titleLabel?.text?.components(separatedBy: ","))!
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        if self.taskName.text != "" {
           print( CoreDataFunctions.deleteRecord(taskName: oldTaskName, entityName: Utilities.task))
        }
    }
    
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        addToCoreData()
        
    }
    func addToCoreData()  {
        if self.taskName.text != "" {
            if isCategorySelected {
                if isDateSelected {
                    let myTask = TaskAttributes()
                    myTask.name = taskName.text!
                    var categoryVariables = categoryButton.titleLabel?.text?.components(separatedBy: ",")
                    myTask.categoryColor = categoryVariables![1]
                    myTask.categoryName = categoryVariables![0]
                    myTask.isCompleted = false
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "MM/dd/yyyy"
                    
                    myTask.completionDate = dateFormatter.date(from: completionDate.text!)!
                    if  CoreDataFunctions.addTaskToCoreData(task: myTask) == true{
                        taskName.text = ""
                        categoryButton.setTitle("Pick a Category", for: .normal)
                        isCategorySelected = false
                        completionDate.text = ""
                        isDateSelected = false
                        errorLabel.isHidden = true
                    }else {
                        errorLabel.isHidden = false
                        errorLabel.text = "Task Already Exist"
                        return
                    }
                }else {
                    errorLabel.isHidden = false
                    errorLabel.text = "Please , select Completion Date"
                    return
                    
                }
            }else {
                errorLabel.isHidden = false
                errorLabel.text = "Please , select Category"
                return
                
            }
            
        }else {
            errorLabel.isHidden = false
            errorLabel.text = "Please , Enter taskName"
            return
        }
    }
    
    
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension NewAndEditTask : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        
        cell.textLabel?.text = categories[indexPath.row].categoryName! + "," + categories[indexPath.row].categoryColor!
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        categoryButton.setTitle(categories[indexPath.row].categoryName! + "," + categories[indexPath.row].categoryColor!, for: .normal)
        self.categoryTableView.isHidden = !self.categoryTableView.isHidden
        isCategorySelected = true
        selectedCategory = indexPath.row
        
    }
    
    
    
    
}
extension NewAndEditTask : UIGestureRecognizerDelegate{
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view?.isDescendant(of: self.categoryTableView) == true {
            return false
        }
        return true
    }
}

