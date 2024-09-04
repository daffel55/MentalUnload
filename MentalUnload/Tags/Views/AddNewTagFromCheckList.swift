//
//  AddNewFolder.swift
//  MentalUnload
//
//  Created by Dagmar Feldt on 28.07.24.
//



import SwiftUI
import SwiftData

struct AddNewTagFromCheckList: View {
    @Environment(\.modelContext) private var context
    @Query var tags : [Tag]
    @Binding var showAddTag : Bool
    @Binding var tagForChecklist : Tag?
    @State var tagName = ""
    @State var tagNameText = NSLocalizedString("newFolderName", comment: "")
    @State private var nameAlert = false
    
    
    var body: some View {
       
        NavigationStack {
            ZStack {
                Form {
                    Section("newFolder") {
                        TextField(tagNameText, text: $tagName)
                    }
                }

               
                
                
              
            }.navigationTitle("create new tag")
                .navigationBarTitleDisplayMode(.inline)
                .alert("This tag already exists", isPresented: $nameAlert, actions: {
                    Button("okay", role: .destructive) {}
                })
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                           showAddTag = false
                        }, label: {
                          Text("Cancel")
                        })
                    }
                    ToolbarItem(placement: .topBarTrailing, content: {
                        Button(action: {
                          
                            if tagName != "" {
                                if tagNameAlreadyExsists(tagName) {
                                    nameAlert = true
                                } else {
                                    let newTag = Tag(name: tagName)
                                    tagForChecklist = newTag
                                    context.insert(newTag)
                                    showAddTag = false
                                }
                            } else {
                                tagNameText = NSLocalizedString("newFolderMustHaveName", comment: "")
                            }
                        }, label: {
                            Text("sav")
                        })
                    })
                }
                
        }
    }
    
    func tagNameAlreadyExsists(_ name: String) -> Bool {
        for tag in tags {
            if tag.name == name {
                return true
            }
        }
        return false
    }
}



