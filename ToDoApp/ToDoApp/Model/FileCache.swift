//
//  FileCache.swift
//  ToDoApp
//
//  Created by Vadim on 24.10.2022.
//

import Foundation

class FileCache {
    var toDolist: [ToDoItem] = []
    
    func addNewTask(task item: ToDoItem?) {
        if let newTask = item {
            toDolist.append(newTask)
        }
    }
    
    func deleteTask(taskId: String) {
        if let index = toDolist.firstIndex(where: { $0.id == taskId }) {
            toDolist.remove(at: index)
        }
    }
    
    func readTaskFromLocalFile(fileName: String) {

        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                let data = try Data(contentsOf: fileUrl)
                
                let newItem = ToDoItem.parse(json: data)
                if let item = newItem {
                    toDolist.append(item)
                }
                
            } catch {
                print("Can't get data from file: \(error.localizedDescription)")
            }
        } else {
            print("Can't read file")
        }
    }
    
    // to form array of dictionaries from tasks and serialize it
    func getTasksInJSON() -> Any? {
        var data: Any? = nil
        var jsonFormatTasks: [Any] = []
        
        for task in toDolist {
            if let taskFormedJSON = task.json {
                jsonFormatTasks.append(taskFormedJSON)
            }
        }
        
        do {
            data = try JSONSerialization.data(withJSONObject: jsonFormatTasks as Any, options: .prettyPrinted)
        } catch {
            print("Error in getting JSON: \(error.localizedDescription)")
        }
        
        return data
    }
    
    func writeTasksToAppFile(fileName: String) {
        let data = getTasksInJSON()
        
        if let data = data as? Data {
            if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last {
                let fileURL = documentsDirectory.appendingPathComponent(fileName)
                do {
                    try data.write(to: fileURL)
                } catch {
                    print("Error with writing JSON to file: \(error.localizedDescription)")
                }
            }
        }
        
    }
    
    func readTasksFromAppFile(fileName: String) {
        
        if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last {
            let fileURL = documentsDirectory.appendingPathComponent(fileName)
            do {
                let data = try Data(contentsOf: fileURL)
                do {
                    let deserealizedTask = try JSONSerialization.jsonObject(with: data)
                    if let deserealizedTask = deserealizedTask as? [Any] {
                        for jsonTask in deserealizedTask {
                            let newItem = ToDoItem.parse(json: jsonTask)
                            
                            if let item = newItem {
                                toDolist.append(item)
                            }
                        }
                    }
                } catch {
                    print("Error with deserialization of data: \(error.localizedDescription)")
                }
            } catch {
                print("Error with writing JSON to file: \(error.localizedDescription)")
            }
        }
    }
}
