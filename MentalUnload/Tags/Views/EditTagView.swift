//
//  EditTagView.swift
//  MentalUnload
//
//  Created by Dagmar Feldt on 28.07.24.
//


import SwiftUI
import SwiftData

struct EditTagView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @Query private var tags : [Tag]
    var tag : Tag?
    @State var tagName = ""
    @State var nameAlert = false
    @State var emptyAlert = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Tag Name") {
                    TextField(tag!.name, text: $tagName)
                    
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading , content: {
                    Button("canc") {
                        dismiss()
                    }
                })
                ToolbarItem(placement: .topBarTrailing, content: {
                    Button("sav") {
                        if tagName != "" {
                            if tagNameAlreadyExsists(tagName) {
                                nameAlert = true
                            } else {
                                tag!.name = tagName
                                dismiss()
                            }
                        } else {
                            emptyAlert = true
                        }
                    }
                })
            }
            .alert("This tag already exsist", isPresented: $nameAlert, actions: {
                Button("okay", role: .destructive) {}
            })
            .alert("You haven't provide a name", isPresented: $emptyAlert, actions: {
                Button("okay", role: .destructive) {}
            })
            .navigationTitle("Edit Tag")
            .navigationBarTitleDisplayMode(.inline)
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
    
    


