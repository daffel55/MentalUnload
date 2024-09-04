//
//  MentalUnloadApp.swift
//  MentalUnload
//
//  Created by Dagmar Feldt on 26.07.24.
//

import SwiftUI

@main
struct MentalUnloadApp: App {
    var body: some Scene {
    
        WindowGroup {
            
                ContentView().colorScheme(.light)
            
        }.modelContainer(for: [StuffedItem.self, CheckListModel.self, SnapTask.self, Memory.self, Tag.self] )
            
            
    }
}

