//
//  AddUntaggedChecklists.swift
//  MentalUnload
//
//  Created by Dagmar Feldt on 21.08.24.
//

import SwiftUI
import SwiftData

struct AddUntaggedChecklists: View {
    @Environment(\.dismiss) var dismiss
    
    var tag : Tag
    @Query var checkLists : [CheckListModel]
    var untaggedChecklists : [CheckListModel] {
        var untagged = [CheckListModel]()
        for list in checkLists {
            if list.tag == nil {
                untagged.append(list)
            }
            
        }
        return untagged
    }
    var body: some View {
        NavigationStack {
            ZStack {
                Color.lightGrey.ignoresSafeArea()
                VStack {
                    Group {
                        Text("Available Checklists for\n\(tag.name)").font(.title2)
                        Text("Only checklists without a tag are listed here.\nIf you want to change the tag of a checklist, you can do so in the edit menu of that checklist.").font(.caption)
                    }.padding()
                    List {
                        
                        ForEach(untaggedChecklists) { list in
                            Button {
                                list.checkedForTag.toggle()
                            } label: {
                                Label(list.title, systemImage: list.checkedForTag ?   "checkmark.square" : "square" )
                            }
                        }
                    }
                }
            }
            .navigationTitle("Add Checklists")
            .toolbar {
                ToolbarItem(placement: .topBarLeading, content: {
                    Button("Cancel") {
                        dismiss()
                    }
                })
                ToolbarItem(placement: .topBarTrailing, content: {
                    Button {
                        for list in untaggedChecklists {
                            if list.checkedForTag {
                                tag.checklists.append(list)
                            }
                        }
                        dismiss()
                    } label: {
                        Text("Save")
                    }
                })
            }
        }
        .overlay(content: {
            if untaggedChecklists.count == 0 {
                ContentUnavailableView("No untagged checklists available", systemImage: "magnifyingglass", description: Text("Checklists can't have more than one tag.\nGo to the checklist, you'd like to add and change its tag."))
            }
            
        })
        .task {
            for index in checkLists.indices {
                checkLists[index].checkedForTag = false
            }
        }
        
    }
}

