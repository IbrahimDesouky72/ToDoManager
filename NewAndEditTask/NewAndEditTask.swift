//
//  NewAndEditTask.swift
//  ToDoManager
//
//  Created by Ahmed Mokhtar on 8/2/18.
//  Copyright © 2018 Ahmed Mokhtar. All rights reserved.
//

import UIKit

class NewAndEditTask: UIViewController {
    
    var categories = [Category]()
    
    @IBOutlet weak var taskName: UITextField!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var categoryTableView: UITableView!
    @IBOutlet weak var completionDate: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // CoreDataFunctions.resetAllRecords()
        categories = CoreDataFunctions.getAllCategories(newAndEditTask: self)
        print(categories.count)
        categoryTableView.isHidden = true
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
        
        
    }

    func updateUI(categories : [Category])  {
        self.categories = categories
        
       
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
    }
    
    
    
    
}
