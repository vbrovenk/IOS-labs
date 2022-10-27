//
//  ToDoItem.swift
//  ToDoApp
//
//  Created by Vadim on 24.10.2022.
//

import Foundation

enum Priority: String {
    case low
    case middle
    case high
}

struct ToDoItem {
    let id: String
    let text: String
    let priority: Priority
    let deadLine: Date?
    
    init(id: String?, text: String, priority: Priority, deadLine: Date?) {
        if let id = id {
            self.id = id
        } else {
            self.id = UUID().uuidString
        }
        self.text = text
        self.priority = priority
        self.deadLine = deadLine
    }
    
    init(jsonData: [String: Any]) {
        self.id = jsonData["id"] as? String ?? UUID().uuidString
        self.text = jsonData["text"] as? String ?? ""
        
        if let priorityLevel = jsonData["priority"] as? String,
            let priority = Priority.init(rawValue: priorityLevel) {
            self.priority = priority
        } else {
            self.priority = .middle
        }
        
        self.deadLine = nil
    }
}

extension ToDoItem {
    
    // returns prepared dictionary for serialization
    var json: Any? {
        if self.priority == .low {
            return nil
        }
        
        var dataForEncode: [String: Any] = ["id": self.id, "text": self.text]
        // add priority if > low
        if self.priority != .low {
            dataForEncode["priority"] = self.priority.rawValue
        }

        return dataForEncode
    }
    
    static func parse(json: Any) -> ToDoItem? {
        
        guard let task = json as? [String: Any] else {
            print("Casting error to [String: Any]")
            return nil
        }
        
        let newToDoItem = ToDoItem(jsonData: task)
        
        return newToDoItem
    }
}
