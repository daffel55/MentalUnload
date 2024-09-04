//
//  Place.swift
//  MentalUnload
//
//  Created by Dagmar Feldt on 27.07.24.
//


import Foundation
import SwiftData

@Model
class Place: Equatable {
    var name : String
    var stuff : [StuffedItem]?
    var id = UUID()
    init(name: String) {
        self.name = name
    }
    
}

