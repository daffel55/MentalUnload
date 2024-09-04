//
//  InfoCheckLists.swift
//  MentalUnload
//
//  Created by Dagmar Feldt on 28.08.24.
//

import SwiftUI

struct InfoCheckLists: View {
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Text("Piloten haken Checklisten vor dem Start ab.\nIch habe **Alles abgehakt** geschrieben, weil ich immer etwas beim An- oder Abkoppeln meines Wohnwagens vergessen habe und so eine Pilotenliste brauchte. Wenn ich unter Druck bin, hilft mir, dass diese Checkliste ein optisches und akustisches Signal gibt, wenn jeder Punkt abgehakt wurde.\nDie Wohnwagenlisten sind schon angelegt. Du kannst sie natürlich gerne löschen oder umschreiben.").font(.title3).padding().background(Color.black).foregroundStyle(.white)
                List {
                    Section("Checkliste erstellen") {
                        Text("Das Icon \(Image(systemName: "plus")) legt eine neue Checkliste an.")
                        Text("Du kannst diese nur speichern, wenn du ihr auch einen Namen gibst und mindestens einen Punkt einträgst. Sinn macht, dass du auch eine Kategorie(Tag) zuordnest (optional).")
                        Text("Du kannst die Hintergrundfarbe einer Liste verändern, z.B. um  sie leichter wieder zu finden.")
                        Text("Mit dem \(Image(systemName: "plus")) hinter jedem Checklistenpunkt erstellst du ein neues Textfeld für den nächsten Punkt.")
                    }
                    Section("Checklisten abhaken") {
                        Text("Drücke auf den Namen der Checkliste, um in die Detailansicht zu kommen. Hier kannst du die einzelnen Punkte abhaken. Du kannst die Haken auch durch erneutes Drücken wieder entfernen.\nHast du alles erledigt, gibt es ein Signal und der Hintergrund wird grün.")
                        Text("Um alle Punkte wieder abzuwählen (reset), drücke auf dieses Symbol: \(Image(systemName: "arrow.counterclockwise"))")
                        Text("Hast du zu viele Checklisten, filtere sie mit mit Hilfe der Kategorien (Tags) \(Image(systemName: "tag")).")
                        Text("Zum bearbeiten und löschen kannst du den Namen der Checkliste nach links ziehen und siehst dann ein Untermneü. Auch in der Detailansicht kannst du die Checkliste bearbeiten: (\(Image(systemName: "pencil"))).")
                    }
                    
                }
            }.navigationTitle("Alles abgehakt")
                
                
                
            
        }
       
    }
}

#Preview {
    InfoCheckLists()
}
