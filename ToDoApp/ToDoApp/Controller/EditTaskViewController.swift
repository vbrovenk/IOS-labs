//
//  EditTaskViewController.swift
//  ToDoApp
//
//  Created by Vadim on 02.11.2022.
//

import UIKit

class EditTaskViewController: UIViewController {
    @IBOutlet weak var taskTextView: UITextView!
    @IBOutlet weak var prioritySegmentControl: UISegmentedControl!
    @IBOutlet weak var needDeadline: UISwitch!
    @IBOutlet weak var calendarPicker: UIDatePicker!
    @IBOutlet weak var saveButton: UIButton!
    
    var delegate: ViewController?
    
    let placeholder = "Input your task here"
    var newPriority: Priority?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        taskTextView.layer.cornerRadius = 15
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let taskIndex = delegate?.currentCellIndex?.row {
            taskTextView.text = delegate?.fileCache.toDolist[taskIndex].text
            
            switch delegate?.fileCache.toDolist[taskIndex].priority {
            case .low:
                prioritySegmentControl.selectedSegmentIndex = 0
            case .middle:
                prioritySegmentControl.selectedSegmentIndex = 1
            case .high:
                prioritySegmentControl.selectedSegmentIndex = 2
            default:
                break
            }
            
            if let deadline = delegate?.fileCache.toDolist[taskIndex].deadLine {
                needDeadline.isOn = true
                calendarPicker.date = deadline
            }
            
            newPriority = delegate?.fileCache.toDolist[taskIndex].priority
        }
    }
    
    @IBAction func backPressButton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func savePressButton(_ sender: Any) {
        var deadline: Date? = nil
        
        if needDeadline.isOn {
            deadline = calendarPicker.date
        }
        
        let updatedTask = ToDoItem(id: nil,
                                   text: taskTextView.text,
                                   priority: newPriority ?? .low,
                                   deadLine: deadline)
        
        // if updatedTask (user changed property) differs from old task
        // then oldTask is removed and updatedTask is add (as ToDoItem is immutable)
        if let taskIndex = delegate?.currentCellIndex?.row {
            if let oldTask = delegate?.fileCache.toDolist[taskIndex] {
                if oldTask.text != updatedTask.text || oldTask.priority != updatedTask.priority ||
                    oldTask.deadLine != updatedTask.deadLine {
                    delegate?.fileCache.deleteTask(taskId: oldTask.id)
                    delegate?.fileCache.addNewTask(task: updatedTask)
                }
            }
        }
        
        delegate?.tasksTableView.reloadData()
        self.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func deleteTaskButton(_ sender: Any) {
        if let taskIndex = delegate?.currentCellIndex?.row {
            if let oldTask = delegate?.fileCache.toDolist[taskIndex] {
                delegate?.fileCache.deleteTask(taskId: oldTask.id)
            }
        }
        delegate?.tasksTableView.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func choosePriority(_ sender: Any) {
        switch prioritySegmentControl.selectedSegmentIndex {
        case 0:
            newPriority = .low
        case 1:
            newPriority = .middle
        case 2:
            newPriority = .high
        default:
            break
        }
    }
    
}

extension EditTaskViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.isEmpty {
            saveButton.isEnabled = false
        } else {
            saveButton.isEnabled = true
        }
    }
}
