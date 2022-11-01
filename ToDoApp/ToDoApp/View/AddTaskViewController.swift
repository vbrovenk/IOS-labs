//
//  AddTaskViewController.swift
//  ToDoApp
//
//  Created by Vadim on 27.10.2022.
//

import UIKit

class AddTaskViewController: UIViewController {
    @IBOutlet weak var taskTextView: UITextView!
    @IBOutlet weak var priorityControl: UISegmentedControl!
    @IBOutlet weak var deadlineSwitch: UISwitch!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    let placeholder = "Input your task here"
    var taskPriority: Priority = .low
    var newTask: ToDoItem? = nil
    
    var delegate: ViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        taskTextView.textColor = .lightGray
        taskTextView.text = placeholder
        taskTextView.layer.cornerRadius = 15
        
        saveButton.isEnabled = false
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveTaskButton(_ sender: Any) {
        var dateOfDeadline: Date? = nil
        
        if deadlineSwitch.isOn {
            dateOfDeadline = datePicker.date
        }
        
        newTask = ToDoItem(id: nil,
                           text: taskTextView.text,
                           priority: taskPriority,
                           deadLine: dateOfDeadline)

        delegate?.fileCache.addNewTask(task: newTask)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func choosePriorityControl(_ sender: Any) {
        switch priorityControl.selectedSegmentIndex {
        case 0:
            taskPriority = .low
        case 1:
            taskPriority = .middle
        case 2:
            taskPriority = .high
        default:
            break
        }
    }
    
}

extension AddTaskViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = ""
            textView.textColor = .black
        }
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.textColor = .lightGray
            textView.text = placeholder
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.isEmpty {
            saveButton.isEnabled = false
        } else {
            saveButton.isEnabled = true
        }
    }
}
