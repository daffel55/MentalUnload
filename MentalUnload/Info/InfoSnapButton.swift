//
//  InfoSnapButton.swift
//  MentalUnload
//
//  Created by Dagmar Feldt on 29.08.24.
//

import SwiftUI



struct InfoSnapButton: View {
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Text("Du musst etwas regelmäßig erledigen (den Wasserfilter erneuern, den Hund entwurmen, deine Mutter anrufen...)? Erstelle dir in **Automatisch wiederholen** eine Aufgabe dafür und trage die Laufzeit ein. Jetzt musst du nur noch einen Knopf drücken, wenn du es erledigt hast und die App kümmert sich darum, dich rechtzeitig an das nächste Malzu erinnern.").font(.title3).padding().background(Color.black).foregroundStyle(.white)
                List {
                    Section("Aufgabe erstellen") {
                        Text("Das Icon \(Image(systemName: "plus")) legt eine neue Aufgabe an.")
                        Text("Du kannst diese nur speichern, wenn du ihr auch einen Namen gibst und eine Laufzeit einträgst.")
                    }
                    Section("Aufgaben benutzen") {
                        Text("Es gibt 3 Zustände einer Aufgabe:")
                        Text("_Hellgrün_ ist eine Aufgabe, die erstellt, aber nicht gestartet ist.\nIn diesem Zustand kannst du die Aufgabe nur löschen oder starten.")
                        Text("Hast du die Aufgabe erledigt, drücke drauf und sie wird _dunkelgrün_. Der Countdown beginnt zu laufen.\nJetzt kannst du die Aufgabe auch bearbeiten (einfach drauf drücken), anhalten ( \(Image(systemName: "stop.circle"))) oder löschen. Willst du Details der Aufgabe sehen, drücke auf \(Image(systemName: "info.circle")).")
                        Text("_Rot_ bedeutet, dass die Aufgabe fällig (überfallig?) ist. Hast du sie erledigt, drücke wieder drauf und der Countdown läuft erneut.\nEine rote Aufgabe kannst du nur löschen oder starten.")
                    }
                    
                }
            }.navigationTitle("Automatisch Wiederholen")
                
            
                
            
        }
       
    }
}
