//
//  InfoView.swift
//  MentalUnload
//
//  Created by Dagmar Feldt on 28.07.24.
//



import SwiftUI

struct InfoView: View {
    var body: some View {
        ZStack {
            Color.lightGrey.ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    Group {
                        Text("Was macht diese App?").font(.title).foregroundStyle(.gray).textCase(.uppercase)
                        Text("Lege Checklisten für wiederkehrende Abläufe an, deren einzelne Punkte du nach Erledigung abhakst. Hast du alles erledigt, gibt dir die App eine optische, haptische und akustische Rückmeldung. Bist du also später unsicher, ob du auch an alles gedacht hast, musst du dich nur erinnern, ob die App dieses Signal gegeben hat. \(Image(systemName: "hand.thumbsup"))")
                        Text("\(Image(systemName: "text.badge.plus")) Drücke auf dieses Symbol, um eine neue Liste zu erstellen.")
                        Text("\(Image(systemName: "folder.badge.plus")) Um Listen besser zu organisieren, kannst du mit diesem Symbol Ordner anlegen.")
                        Text("\(Image(systemName: "pencil")) Hiermit kannst du eine Liste bearbeiten.")
                        Text("\(Image(systemName: "rectangle.and.pencil.and.ellipsis")) Hiermit kannst du einen Ordner bearbeiten.")
                        Text("\(Image(systemName: "trash")) Hiermit kannst du eine Liste oder einen Ordner löschen. Löschst du einen Ordner, der Listen enthält, werden diese unter 'Einzelne Listen' angezeigt, nachdem sie ihren Ordner verloren haben.")
                    }
                    Group {
                        Text("Listen").font(.title2).foregroundStyle(.gray).textCase(.uppercase)
                        Text("Drückst du auf den Namen einer Liste, kommst du in die Ansicht der Liste mit ihren einzelnen Punkten, die du nun abhaken kannst.\nDu kannst jeden Punkt nach Belieben an - und abhaken. Willst du alle Haken löschen, drücke auf \(Image(systemName: "arrow.counterclockwise")).\nDu kannst das Erledigen einer Liste auch unterbrechen, die App merkt sich, welche Haken du schon gesetzt hast.")
                        Text("Auch in dieser Ansicht findest du den Stift \(Image(systemName: "pencil")) um direkt in das Bearbeitungsmenü für diese Liste zu gelangen.")
                    }
                    Group {
                        Text("Listen anlegen oder verändern").font(.title2).foregroundStyle(.gray)
                        Text("Gebe den Listen einen Namen und trage die einzelnen Listenpunkte ein. Wähle eine Farbe aus und - falls du schon Ordner angelegt hast - den passenden Ordner. \nMöchtest du eine bestehende Liste ändern, wähle \(Image(systemName: "pencil")) ")
                    }
                    Group {
                        Text("Ordner").font(.title2).foregroundStyle(.gray).textCase(.uppercase)
                        Text("Es kann Sinn machen, die Listen in Ordner zu legen. Zum Beispiel die schon angelegten Listen (Wohnwagen...) in einen Ordner namens Wohnwagen")
                        Text("Drücke auf das Neuer-Ordner-Symbol \(Image(systemName: "square.grid.3x1.folder.badge.plus")) oben rechts und du kannst einen neuen Ordner anlegen (überraschenderweise). Gebe dem Ordner einen Namen und wähle Listen für den Ordner aus.\nEs werden dir nur Listen angezeigt, die noch keinem Ordner zugeordnet sind. Du kannst auch direkt eine neue Liste anlegen, die dann diesem Ordner zugeordnet wird. Solltest du das Anlegen des Ordners abbrechen, wird dir diese Liste unter den einzelnen Listen angezeigt.")
                    }
                    Group {
                        Text("Ordner anlegen oder verändern").font(.title2).foregroundStyle(.gray)
                        Text("Um bestehende Orner zu veräandern, drücke auf \(Image(systemName: "rectangle.and.pencil.and.ellipsis")). Du kannst den Namen verändern und Listen abwählen. Diese Listen erscheinen dann unter den einzelnen Listen im Hauptmenü. \nDu kannst auch aus dem Ordner-Bearbeiten-Menü direkt eine neue Liste anlegen.\nOrdner haben immer einen weißen Hintergrund!")
                    }
                    
                    Group {
                        Text("Rechtliches").font(.title2).foregroundStyle(.gray).textCase(.uppercase)
                        Text("Copyright: Dagmar Feldt")
                        Text("c/o Cobaas")
                        Text("Tel. ‭+49 155 66052337‬")
                        
                    }
                    
                    
                    
                }.padding().foregroundStyle(.black)
            }
        }
    }
}


