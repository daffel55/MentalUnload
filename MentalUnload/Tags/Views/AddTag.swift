//
//  AddNewTag.swift
//  MentalUnload
//
//  Created by Dagmar Feldt on 20.08.24.
//

import SwiftUI
import SwiftData

struct AddTag: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @Query var tags : [Tag]
    @State var tagName = ""
    @State var tagNameText = NSLocalizedString("newFolderName", comment: "")
   @State private var nameAlert = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Tag Name") {
                    TextField(tagNameText, text: $tagName)
                }
            }
            .alert("This tag already exists", isPresented: $nameAlert, actions: {
                Button("okay", role: .destructive) {}
            })
            .toolbar{
                ToolbarItem(placement: .topBarLeading, content: {
                    Button("Cancel") {
                        dismiss()
                    }
                })
                ToolbarItem(placement: .topBarTrailing, content: {
                    Button(action: {
                        if tagName != "" {
                            if tagNameAlreadyExsists(tagName) {
                                nameAlert = true
                            } else {
                                let newTag = Tag(name: tagName)
                                context.insert(newTag)
                                dismiss()
                            }
                        } else {
                            tagNameText = NSLocalizedString("newFolderMustHaveName", comment: "")
                        }
                    }, label: {
                        Text("Save")
                    })
                })
            }
            .navigationTitle("Add New Tag")
           // .navigationBarTitleDisplayMode(.inline)
                
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
