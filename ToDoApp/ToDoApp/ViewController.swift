//
//  ViewController.swift
//  ToDoApp
//
//  Created by Vadim on 24.10.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tasksTableView: UITableView!
    var fileCache = FileCache()
    var currentCellIndex: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let tasks = [ToDoItem(id: "1", text: "Clean", priority: .middle, deadLine: nil),
                     ToDoItem(id: "2", text: "Play", priority: .high, deadLine: nil)]
        
        
        
//        print("LIST: \(fileCache.toDolist)")
//        print("===================================")
//        fileCache.deleteTask(taskId: "1")
//        fileCache.deleteTask(taskId: "2")
        
//        
        fileCache.readTasksFromAppFile(fileName: "forWriting.json")
        print("LIST: \(fileCache.toDolist)")
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueAddTask" {
            if let destination = segue.destination as? AddTaskViewController {
                destination.delegate = self
//                destination.modalPresentationStyle = .fullScreen
            }
        } else if segue.identifier == "segueEditTask" {
            if let destination = segue.destination as? EditTaskViewController {
                destination.delegate = self
            }
        }
    }

}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fileCache.toDolist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskTableViewCell
        cell.setProperties(task: fileCache.toDolist[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.currentCellIndex = indexPath
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            fileCache.toDolist.remove(at: indexPath.row)
            tasksTableView.reloadData()
        }
    }
}

