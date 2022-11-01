//
//  ViewController.swift
//  ToDoApp
//
//  Created by Vadim on 24.10.2022.
//

import UIKit

class ViewController: UIViewController {
    var fileCache = FileCache()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let tasks = [ToDoItem(id: "1", text: "Clean", priority: .middle, deadLine: nil),
                     ToDoItem(id: "2", text: "Play", priority: .high, deadLine: nil)]
        
        
        
        print("LIST: \(fileCache.toDolist)")
//        print("===================================")
//        fileCache.deleteTask(taskId: "1")
//        fileCache.deleteTask(taskId: "2")
        
//        
//        fileCache.readTasksFromAppFile(fileName: "forWriting.json")
//        print("LIST: \(fileCache.toDolist)")
        
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueAddTask" {
            if let destination = segue.destination as? AddTaskViewController {
                destination.delegate = self
//                destination.modalPresentationStyle = .fullScreen
            }
        }
    }

}

