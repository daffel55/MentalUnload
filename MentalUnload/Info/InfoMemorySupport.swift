//
//  InfoMemorySupport.swift
//  MentalUnload
//
//  Created by Dagmar Feldt on 29.08.24.
//

import SwiftUI

struct InfoMemorySupport: View {
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Text("Du möchtest dir merken, wo du in Urlaub warst und wie das tolle Hotel hieß und dich auch erinnern, dass du noch eine Bewertung schreiben wolltest? Oder dass du einen Teil des Gartenzaun gestrichen hast und möchtest dir notieren, wie weit du gekommen bist und welche Farbe du benutzt hast? Dann ist **Gedächtnisstütze** richtig. Der Platz für Erinnerungen, Erkenntnisse und übriggebliebene Aufgaben." ).font(.title3).padding().background(Color.black).foregroundStyle(.white)
                List {
                    Section("Gedächtnisstütze erstellen") {
                        Text("Das Icon \(Image(systemName: "plus")) legt eine neue Erinnerung an.")
                        Text("Du kannst diese nur speichern, wenn du ihr auch einen Namen gibst. Sinn macht, dass du auch eine Kategorie(Tag) zuordnest (optional).")
                        Text("Füge Details zu der Erinnerung im Feld Beschreibung hinzu.")
                        Text("Im Fazit kannst du festhalten, was du an Erkenntissen gewonnen hast (nächstes Mal früher buchen, eine andere Farbe verwenden...)")
                        Text("Du kannst auch ein (1!) Bild aus der Fotos-App hinzufügen.")
                        Text("Ergeben sich aus dem ganzen noch weitere Aufgaben (z.B. muss noch ein zweites Mal gestrichen werden, das Hotel hat eine gute Bewertung verdient...), kannst du diese unten eintragen. \nDas Plus im Textfeld erzeugt ein neues für weitere Aufgaben.")
                        
                    }
                    Section("Gedächtnisstützen finden") {
                        Text("Gebe Text in das Suchfeld ein, es wird im Namen, in der Beschreibung und im Fazit gesucht.")
                        Text("Mit \(Image(systemName: "line.3.horizontal.decrease.circle")) kannst du kannst dir alle vorhandenen Gedächtnisstützen anzeigen lassen oder nach unerledigten Aufgaben filtern. \nMit \(Image(systemName: "tag")) filterst du nach Kategorien.")
                        Text("Drücken auf den Namen öffnet die Detailansicht.\nHier kannst du auch erledigte Aufgaben abhaken.")
                        Text("Zum bearbeiten und löschen kannst du den Namen der Erinnerung nach links ziehen und siehst dann ein Untermneü. Auch in der Detailansicht kannst du die Erinnerung bearbeiten: (\(Image(systemName: "pencil"))).")
                    }
                    
                }
            }.navigationTitle("Gedächtnisstütze")
                
                
                
            
        }
       
    }
}

#Preview {
    InfoMemorySupport()
}
