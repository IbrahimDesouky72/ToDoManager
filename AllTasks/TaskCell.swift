//
//  TaskCell.swift
//  ToDoManager
//
//  Created by Ahmed Mokhtar on 7/31/18.
//  Copyright © 2018 Ahmed Mokhtar. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {

    @IBOutlet weak var completionDate: UILabel!
    @IBOutlet weak var taskName: UILabel!
    @IBOutlet weak var colorName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
