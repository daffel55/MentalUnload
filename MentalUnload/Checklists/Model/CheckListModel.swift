//
//  CheckListModel.swift
//  MentalUnload
//
//  Created by Dagmar Feldt on 28.07.24.


import Foundation
import SwiftData
import SwiftUI

@Model
class CheckListModel {
    var title: String
    var items : [CheckListItem]
    var color : Int
    var checked = false
    var checkedForTag = false
    var tag: Tag?
    init(title: String, items: [CheckListItem], colorValue : Int = 0x005392, tag: Tag?) {
        self.title = title
        self.items = items
        self.color = colorValue
        self.tag = tag
    }
    
}

extension CheckListModel {
    var allChecked : Bool {
        for item in items {
            if !item.checked {
                return false
            }
        }
        return true
    }
    
    func uncheckAll() {
        for index in items.indices {
            items[index].checked = false
        }
    }
    func toggleCheckItem(item: CheckListItem) {
        for index in self.items.indices {
            if self.items[index].name == item.name {
                self.items[index].checked.toggle()
            }
        }
    }
}

extension CheckListModel {
    var fontColor : Color {
        if color == 0xFFFFFF {
            return Color.black
        } else {
            return Color.white
        }
    }
}


struct CheckListItem: Codable, Hashable, Identifiable {
    var name: String
    var checked: Bool = false
    var id = UUID()
}
import Foundation
