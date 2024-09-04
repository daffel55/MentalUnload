
//
//  StuffedItem.swift
//  StuffApp
//
//  Created by Dagmar Feldt on 20.07.24.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class StuffedItem {
    var name: String = ""
    var detailedPlace : String = ""
    var remarks : String = ""
    
    @Relationship(inverse: \Place.stuff)
    var place : Place?
    var image : Data?
    
    var tag : Tag?
    
    init(name: String,  place: Place? = nil) {
        self.name = name
        self.place = place
    }
    
}

extension StuffedItem {
    var viewImage : UIImage {
        if let data = image, let uiImage = UIImage(data: data) {
            return uiImage
        } else {
            return UIImage(systemName: "photo")!
        }
    }
    
    var hasImage : Bool {
        image != nil
    }
}

