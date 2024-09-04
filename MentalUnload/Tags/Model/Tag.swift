//
//  CheckListFolder.swift
//  MentalUnload
//
//  Created by Dagmar Feldt on 28.07.24.
//



import Foundation
import SwiftData
import SwiftUI

@Model
class Tag {
    var name : String
    @Relationship(inverse: \CheckListModel.tag)
    var checklists: [CheckListModel] = []
    @Relationship(inverse: \StuffedItem.tag)
    var stuff : [StuffedItem] = []
    @Relationship(inverse: \Memory.tag)
    var memories: [Memory] = []
    init(name: String) {
        self.name = name
    }
}

extension Tag {
    func getUsedInPlacesCount() -> Int {
        var count = 0
        if !stuff.isEmpty {
            count += 1
        }
        if !checklists.isEmpty {
           count += 1
        }
        if !memories.isEmpty {
            count += 1
        }
        return count
    }
    func getImages() -> some View {
        HStack {
            
            if !stuff.isEmpty {
                Image(systemName: "archivebox")
            }
            if !checklists.isEmpty {
                Image(systemName: "checkmark.square")
            }
            if !memories.isEmpty {
                Image(systemName: "square.and.pencil")
            }
        }
    }
    
    
}
