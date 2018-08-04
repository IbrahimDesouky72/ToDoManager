//
//  Setting.swift
//  ToDoManager
//
//  Created by Ahmed Mokhtar on 8/1/18.
//  Copyright © 2018 Ahmed Mokhtar. All rights reserved.
//

import UIKit
import CoreData

class Setting: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var buttonLabel: UIButton!
    @IBOutlet weak var categoryName: UITextField!
    var isColorSelected = false
    var colors = ["red","green","blue","gray","lightGray","black","white","yellow","brown","clear","magenta","purple","orange"]
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.isHidden = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func buttonPressed(_ sender: UIButton) {
        self.tableView.isHidden = !self.tableView.isHidden
    }
    
    @IBAction func saveToCoreDate(_ sender: UIBarButtonItem) {
        
        if self.categoryName.text != "" {
            
            if isColorSelected == true {
            let newCategory = CategoryAttributes()
                newCategory.categoryName = categoryName.text!
                newCategory.categoryColor = (buttonLabel.titleLabel?.text)!
                if CoreDataFunctions.addCategoryToCoreData(newCategory: newCategory){
                    clearData()
                    
                }else{
                    print("exist")
                    errorLabel.isHidden = false
                    errorLabel.text = "Category is Exist"
                }
        
        
            
        
            }else{
                
                errorLabel.isHidden = false
                errorLabel.text = "select color"
            }
        }else{
           
            errorLabel.isHidden = false
            errorLabel.text = "Enter Category Name"
        }
    }
    
    func clearData()  {
        categoryName.text = ""
        buttonLabel.setTitle("Select Color", for: .normal)
        isColorSelected = false
        errorLabel.isHidden = true
    }
    
    func fetchRecord(name: String) -> Bool {
        let appDelegete = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegete.persistentContainer.viewContext
        
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Category")
        let myPredicate = NSPredicate(format: "categoryName = %@",name)
        fetchRequest.predicate = myPredicate
        var result : Bool = false
        
        do {
            var m = [Category]()
            m = try managedContext.fetch(fetchRequest) as! [Category]
            if m.count > 0 {
                result = true
                print(m[0].categoryColor ?? "hello")
            }
            
        }catch{
            print("error")
        }
        return result
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
extension Setting : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.colors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = colors[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.buttonLabel.setTitle(colors[indexPath.row], for: .normal)
        self.tableView.isHidden = true
        isColorSelected = true
    }
    
    
    
    
}
