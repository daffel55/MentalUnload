//
//  InfoTag.swift
//  MentalUnload
//
//  Created by Dagmar Feldt on 29.08.24.
//

import SwiftUI

struct InfoTag: View {
    var body: some View {
       
            NavigationStack {
                VStack {
                    Spacer()
                    Text("Tags (Kategorien) helfen dir, deine Daten zu sortieren. Checklisten, Kram und Erinnerungen lassen sich nach Tags filtern. \nUm diese Tags zu organisieren, benutze den Menüpunkt 'Tags' im Hauptbildschirm. ").font(.title3).padding().background(Color.black).foregroundStyle(.white)
                    List {
                        Section("Tag erstellen") {
                            Text("Das Icon \(Image(systemName: "plus")) legt einen neuen Tag an.")
                            Text("Du kannst diese nur speichern, wenn du ihm auch einen Namen gibst")
                          
                            Text("Einen neuen Tag kannst du auch im Tag-Menü \(Image(systemName: "tag")) der anderen Unterprogramme anlegen.")
                        }
                        Section("Tags benutzen") {
                            Text("Die kleinen Icons hinter dem Tagnamen zeigen an, in welchen Bereichen der Tag bereits benutzt worden ist (ist kein Icon zu sehen, benutzt noch kein Teil diesen Tag)")
                            Text("\(Image(systemName: "archivebox")) zeigt dir allen Kram an, der diesem Tag zu geordnet ist.")
                            Text("\(Image(systemName: "checkmark.square")) zeigt dir alle zugehörigen Checklisten an.")
                            Text("\(Image(systemName: "square.and.pencil")) zeigt dir alle Gedächtnisstützen an.")
                        }
                        Section("Tags bearbeiten") {
                            Text("Wische den Namen eines Tags nach links, es erscheinen Icons zum Bearbeiten oder Löschen des Tags.")
                        }
                        
                    }
                }.navigationTitle("Tags (Kategorien)")
                    
                    
                    
                
            }
           
        }
    
}

