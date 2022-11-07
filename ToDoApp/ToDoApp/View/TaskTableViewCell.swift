//
//  TaskTableViewCell.swift
//  ToDoApp
//
//  Created by Vadim on 02.11.2022.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    @IBOutlet weak var taskLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setProperties(task: ToDoItem) {
        taskLabel.text = task.text
    }

}
