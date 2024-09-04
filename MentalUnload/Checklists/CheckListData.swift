//
//  CheckListData.swift
//  MentalUnload
//
//  Created by Dagmar Feldt on 28.07.24.
//
//

import Foundation
import SwiftUI

//the colors the user can choose as background for the checklist
let colors = [Color.ocean, Color.clover, Color.grape, Color.marascino, Color.tangerine, Color.tin]
//the hax values of those colors, because they can be stored with SwiftData
let colorInts = [0x005392, 0x008E00, 0x9437FF, 0xFF2600, 0xFF9300]

//takes a hex value and gives a Color
extension Color {
    init(hex: Int, opacity: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: opacity
        )
    }
}

// preinstalled checklists that get loaded when the user starts the app for the first time
let checkListTag = Tag(name: "Camping")
let checkListWohnwagenAn = CheckListModel(title: "Wohnwagen ankoppeln", items: [CheckListItem(name: "Am Auto Handbremse angezogen"),CheckListItem(name: "Kupplung gut fest"), CheckListItem(name: "Fangseil fest"), CheckListItem(name: "Strom einstecken und überprüfen"), CheckListItem(name: "Stützrad hoch und gut sichern"), CheckListItem(name: "Handbremse vom Wohnwagen los"), CheckListItem(name: "Mover los, Moverstrom aus, Fernbedienung und Hebel verpacken"), CheckListItem(name: "Türen und Fenster am Wohnwagen verschlossen, auch das Oberlicht"), CheckListItem(name: "Gasflasche abgedreht und gesichert")],colorValue: 0xFFFFFF, tag: checkListTag )

let checkListCaravanHitched = CheckListModel(
    title: "Hitching the Caravan",
    items: [
        CheckListItem(name: "Handbrake engaged on the car"),
        CheckListItem(name: "Coupling secured"),
        CheckListItem(name: "Safety cable secured"),
        CheckListItem(name: "Plug in and check electrical connection"),
        CheckListItem(name: "Jockey wheel raised and secured"),
        CheckListItem(name: "Release caravan handbrake"),
        CheckListItem(name: "Disengage mover, turn off mover power, pack remote control and lever"),
        CheckListItem(name: "Doors and windows of the caravan closed, including the skylight"),
        CheckListItem(name: "Gas bottle turned off and secured")],colorValue: 0xFFFFFF, tag: checkListTag)
    

let checkListWohnwagenVerlassen = CheckListModel(title: "Wohnwagen auf Campingplatz lassen", items: [CheckListItem(name: "Fenster und Oberlicht zu und verdunkeln"), CheckListItem(name: "Kühlschrank leer, aus und offen"), CheckListItem(name: "Strom ausstellen"), CheckListItem(name: "Gas und Wasserpumpe ausstellen"), CheckListItem(name: "Stehendes Wasser leeren"), CheckListItem(name: "Müll mitnehmen"), CheckListItem(name: "Handy, Geld etc. mitnehmen"), CheckListItem(name: "Türen abschließen"), CheckListItem(name: "Polster ins Zelt legen"), CheckListItem(name: "Im Zelt Vorhänge schließen"), CheckListItem(name: "Alle Reißverschlüsse schließen")], colorValue: 0xFFFFFF, tag: checkListTag)

let leaveCaravanAlone =  CheckListModel(
    title: "Leaving the Caravan at the Campsite",
    items: [
        CheckListItem(name: "Close and darken windows and skylight"),
        CheckListItem(name: "Fridge empty, off, and open"),
        CheckListItem(name: "Turn off electricity"),
        CheckListItem(name: "Turn off gas and water pump"),
        CheckListItem(name: "Drain standing water"),
        CheckListItem(name: "Take out trash"),
        CheckListItem(name: "Take mobile phone, money, etc."),
        CheckListItem(name: "Lock doors"),
        CheckListItem(name: "Put cushions in the tent"),
        CheckListItem(name: "Close curtains in the tent"),
        CheckListItem(name: "Close all zippers")
    ], colorValue: 0xFFFFFF, tag: checkListTag)



let checkListDemo = CheckListModel(
    title: "Demo", items: [
        CheckListItem(name: "Hake einen Punkt der Checkliste ab"),
        CheckListItem(name: "Verändere das Aussehen der Checkliste mit dem Bearbeitenmenü (Stift-Symbol)"),
        CheckListItem(name: "Lege im Hauptmenü einen Ordner an (Ordnersymbol mit plus) und lege diese Checkliste hinein"),
        CheckListItem(name: "Erstelle eine neue Checkliste mit dem entsprechenden Symbol im Hauptmenü (4 Linien und ein Plus)"),
        CheckListItem(name: "Lösche den Ordner mit der Demo-Checkliste darin und schau was passiert"),
        CheckListItem(name: "Hake dann alle Punkte der Checkliste ab und schau was passiert, danach verändere einige Punkte wieder auf 'unerledigt' oder drücke den Resetknopf (Kreispfeil gegen Uhrzeigersinn")], tag: nil)

let checkListDemoEnglsh = CheckListModel(
    title: "Demo",
    items: [
        CheckListItem(name: "Check off an item on the checklist"),
        CheckListItem(name: "Change the appearance of the checklist using the edit menu (pencil icon)"),
        CheckListItem(name: "Create a tag in the main menu (tag icon with plus) and put this checklist in it"),
        CheckListItem(name: "Create a new checklist with the corresponding icon in the main menu (4 lines and a plus)"),
        CheckListItem(name: "Check off all items on the checklist and see what happens, then uncheck some items or press the reset button (counterclockwise arrow)")
    ],
    tag: nil
)



let checkListWohnwagenAb = CheckListModel(title: "Wohnwagen abkuppeln", items: [CheckListItem(name: "Handbremse am Wohnwagen fest"), CheckListItem(name: "Stützrad herunter, gut sichern und hochkurbeln, Kupplung lösen"), CheckListItem(name: "Strom abziehen"), CheckListItem(name: "Fangseil abnehmen"), CheckListItem(name: "Wohnwagen nur betreten, wenn abgestützt")], colorValue: 0xFFFFFF, tag: checkListTag)

let checkListCaravanUnhitched = CheckListModel(
    title: "Unhitching the Caravan",
    items: [
        CheckListItem(name: "Handbrake on the caravan applied"),
        CheckListItem(name: "Lower support wheel, secure well, and crank up, release hitch"),
        CheckListItem(name: "Disconnect electricity"),
        CheckListItem(name: "Remove safety cable"),
        CheckListItem(name: "Enter caravan only when supported")
    ],
    colorValue: 0xFFFFFF,
    tag: checkListTag
)



