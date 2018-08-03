//
//  Task.swift
//  ToDoManager
//
//  Created by Ahmed Mokhtar on 7/31/18.
//  Copyright © 2018 Ahmed Mokhtar. All rights reserved.
//

import Foundation
class TaskAttributes {
    
    var name : String
    var categoryName : String
    var categoryColor : String
    var completionDate : Date
    var isCompleted : Bool
    
    init() {
        name = ""
        categoryName = ""
        categoryColor = ""
        completionDate = Date()
        isCompleted = false
    }
}
