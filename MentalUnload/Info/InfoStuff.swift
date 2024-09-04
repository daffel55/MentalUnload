//
//  InfoStuff.swift
//  MentalUnload
//
//  Created by Dagmar Feldt on 28.08.24.
//

import SwiftUI

struct InfoStuff: View {
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Text("Du weißt nicht mehr, wo du im letzten Jar deinen Schlafsack hingelegt hast? Oder die eine komische Schraube, die du an einen sicheren Ort verstaut hast? Vertraue dies dem **Kramverstauer** an.").font(.title3).padding().background(Color.black).foregroundStyle(.white)
                List {
                    Section("Kram verstauen") {
                        Text("\(Image(systemName: "plus")) legt einen neuen Kram an.")
                        Text("Du kannst nur speichern, wenn du dem Kram auch einen Namen gibst. Sinn macht, dass du auch einen Ort benennst und/oder eine Kategorie(Tag).")
                        Text("Du kannst den Ort genauer beschreiben, zusätzliche Informationen und ein Foto eintragen")
                    }
                    Section("Kram wiederfinden") {
                        Text("Gib Text im Suchfeld ein, es wird sowohl im Namen als auch in den zusätzlichen Informationen gesucht.")
                        Text("Suche mit \(Image(systemName: "tag")) in den Kategorien oder der suche mit \(Image(systemName: "archivebox")) in den Plätzen. Hier kannst du auch Plätze bearbeiten oder löschen und natürlich auch neue Plätze anlegen. Drücke auf den Namen des Platzes, um dir alle Gegenstände dort anzeigen zu lassen.")
                        Text("Drückst du auf den Namen des Krams, werden dir die Details angezeigt. Zum bearbeiten und löschen kannst du den Namen des Gegenstandes nach links ziehen und siehst dann ein Untermneü. In der Detailansicht befinden sich oben am Bildschirm entsprechende Menüpunkte (\(Image(systemName: "pencil")), \(Image(systemName: "trash"))).")
                    }
                    
                }
            }
                
                
                
            
        }
       
    }
}

#Preview {
    InfoStuff()
}
