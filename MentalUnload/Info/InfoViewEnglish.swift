//
//  InfoViewEnglish.swift
//  MentalUnload
//
//  Created by Dagmar Feldt on 28.07.24.
//

import SwiftUI

struct InfoViewEnglish: View {
    var body: some View {
        ZStack {
            Color.lightGrey.ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    Group {
                        Text("What does this app do?").font(.title).foregroundStyle(.gray).textCase(.uppercase)
                        Text("Create checklists for recurring processes, where you can check off individual items after completion. Once you’ve completed everything, the app will give you visual, haptic, and auditory feedback. If you later become unsure whether you remembered everything, just recall if the app gave you this signal. \(Image(systemName: "hand.thumbsup"))")
                        Text("\(Image(systemName: "text.badge.plus")) Tap this icon to create a new list.")
                        Text("\(Image(systemName: "folder.badge.plus")) To better organize your lists, you can create folders with this icon.")
                        Text("\(Image(systemName: "pencil")) Use this to edit a list.")
                        Text("\(Image(systemName: "rectangle.and.pencil.and.ellipsis")) Use this to edit a folder.")
                        Text("\(Image(systemName: "trash")) Use this to delete a list or folder. If you delete a folder that contains lists, these lists will be displayed under 'unassigned Lists' after they lose their folder.")
                    }
                    Group {
                        Text("Lists").font(.title2).foregroundStyle(.gray).textCase(.uppercase)
                        Text("Tap on the name of a list to view its individual items, which you can then check off.\nYou can check and uncheck each item at will. To clear all checks, press \(Image(systemName: "arrow.counterclockwise")).\nYou can also interrupt the completion of a list, and the app will remember which checks you have already set.")
                        Text("In this view, you will also find the pencil \(Image(systemName: "pencil")) to directly access the edit menu for this list.")
                    }
                    Group {
                        Text("Creating or editing lists").font(.title2).foregroundStyle(.gray)
                        Text("Give the lists a name and enter the individual list items. Choose a color and, if you have already created folders, select the appropriate folder.\nTo edit an existing list, choose \(Image(systemName: "pencil")) ")
                    }
                    Group {
                        Text("Folders").font(.title2).foregroundStyle(.gray).textCase(.uppercase)
                        Text("It can be useful to place lists in folders. For example, place the already created lists (caravan...) in a folder named Caravan.")
                        Text("Tap the New Folder icon \(Image(systemName: "square.grid.3x1.folder.badge.plus")) at the top right to create a new folder (surprisingly). Give the folder a name and select lists for the folder.\nOnly lists that are not yet assigned to a folder will be displayed. You can also create a new list directly and assign it to this folder. If you cancel the creation of the folder, this list will be displayed under unassigned lists.")
                    }
                    Group {
                        Text("Creating or editing folders").font(.title2).foregroundStyle(.gray)
                        Text("To edit existing folders, tap \(Image(systemName: "rectangle.and.pencil.and.ellipsis")). You can change the name and deselect lists. These lists will then appear under unassigned lists in the main menu.\nYou can also create a new list directly from the folder edit menu.\nFolders always have a white background!")
                    }
                    
                    Group {
                        Text("Legal").font(.title2).foregroundStyle(.gray).textCase(.uppercase)
                        Text("Copyright: Dagmar Feldt")
                        Text("c/o Cobaas")
                        Text("Tel. ‭+49 155 66052337‬")
                        
                    }
                    
                    
                    
                }.padding().foregroundStyle(.black)
            }
        }
    }
}
