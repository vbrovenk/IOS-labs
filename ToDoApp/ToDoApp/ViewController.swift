//
//  ViewController.swift
//  ToDoApp
//
//  Created by Vadim on 24.10.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let tasks = [ToDoItem(id: "1", text: "Clean", priority: .middle, deadLine: nil),
                     ToDoItem(id: "2", text: "Play", priority: .high, deadLine: nil)]
        
        
        var fileCache = FileCache()
        fileCache.addNewTask(task: tasks[0])
        fileCache.addNewTask(task: tasks[1])
        print("LIST: \(fileCache.toDolist)")
        print("===================================")
//        fileCache.writeTasksToAppFile(fileName: "forWriting.json")
        fileCache.deleteTask(taskId: "1")
        fileCache.deleteTask(taskId: "2")
        print("LIST: \(fileCache.toDolist)")
        print("===================================")
        
        fileCache.readTasksFromAppFile(fileName: "forWriting.json")
        print("LIST: \(fileCache.toDolist)")
        
        
        
    }


}

