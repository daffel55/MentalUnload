//
//  Memory.swift
//  MentalUnload
//
//  Created by Dagmar Feldt on 28.07.24.
//



import Foundation
import SwiftUI
import SwiftData

@Model
class Memory {
    var title : String = ""
    var descriptionText : String = ""
    var conclusion : String = ""
    var date = Date.now
    var furtherNotice : Bool = false
    var unfinishedTasks : [UnfinishedTask] = []
    var tag : Tag?
    @Attribute(.externalStorage)
    var image : Data?
    
    init(title: String, descriptionText: String, conclusion: String) {
        self.title = title
        self.descriptionText = descriptionText
        self.conclusion = conclusion
    }
}

extension Memory {
    func toggleTaskCheck(item: UnfinishedTask) {
        for index in self.unfinishedTasks.indices {
            if self.unfinishedTasks[index].name == item.name {
                self.unfinishedTasks[index].checked.toggle()
            }
        }
    }
    
    func numberOfOpenTasks() -> Int {
        guard !self.unfinishedTasks.isEmpty else {return 0}
        var count = 0
        for task in unfinishedTasks {
            if !task.checked  {
                count += 1
            }
        }
        return count
    }
}

extension Memory {
    var viewImage: UIImage {
        if let data = image, let image = UIImage(data: data) {
            return image
        } else {
            return UIImage(systemName: "note.text")!
        }
    }
    
    var hasImage : Bool {
        image != nil
    }
}
struct  UnfinishedTask : Codable, Hashable, Identifiable{
    var name: String
    var checked: Bool = false
    var id = UUID()
}

