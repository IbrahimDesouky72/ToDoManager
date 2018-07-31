//
//  Task.swift
//  ToDoManager
//
//  Created by Ahmed Mokhtar on 7/31/18.
//  Copyright © 2018 Ahmed Mokhtar. All rights reserved.
//

import Foundation
class Task {
    
    var name : String
    var categoryName : String
    var categoryColor : String
    var completionDate : Date
    
    init() {
        name = ""
        categoryName = ""
        categoryColor = ""
        completionDate = Date()
    }
}
