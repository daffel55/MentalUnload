//
//  AddPlaceView.swift
//  MentalUnload
//
//  Created by Dagmar Feldt on 27.07.24.
//  Refactored 09.08.24



import SwiftUI
import SwiftData

/// View to add a new place, user can't enter palces with identical names
struct AddPlaceView: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    @Query var places : [Place]
    @State private var placeName = ""
    @State private var showNameExistsAlert = false
    @State private var placeMustHaveNameAlert = false
    @State private var borderToRed = false
    var body: some View {
        
            NavigationStack {
                ZStack(alignment: .center) {
                    Color.lightGrey.ignoresSafeArea()
                    
                        Form {
                            Section("Name of the place") {
                                TextField("Name of the place", text: $placeName).font(.title).foregroundStyle(.black)
                                    .textFieldStyle(.roundedBorder)
                                    .border(borderToRed ? Color.red : Color.clear)
                                    .onChange(of: placeName, {
                                        borderToRed = false
                                    })
                                    
                            }
                        }.foregroundStyle(.gray).background(.lightGrey)
                            
                        Text("Choose major category places like a room, a shed, the attic or cellar.\nThen specify something like a cupboard, shelf or box in the detailed description field provided in the item's menu.")
                        .padding()
                        .navigationTitle("Add New Place").navigationBarTitleDisplayMode(.inline)
                .toolbar(content: {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                    ToolbarItem(placement: .topBarTrailing,content: {
                        Button("Save") {
                            if !placeNameExists() && placeName != ""{
                                let newPlace = Place(name: placeName)
                                context.insert(newPlace)
                                dismiss()
                            } else {
                                if placeNameExists() {
                                    borderToRed = true
                                    showNameExistsAlert = true
                                } else {
                                    borderToRed = true
                                    placeMustHaveNameAlert = true
                                }
                            }
                        }
                    })
                })
            }
        }
        .alert("Name already exsits!", isPresented: $showNameExistsAlert) {
            Button("Okay", role: .cancel)  {}
        }
        .alert("Place must have a name!", isPresented: $placeMustHaveNameAlert) {
            Button("Okay", role: .cancel) {}
        }
    }
    
    func placeNameExists() -> Bool {
        for place in places {
            if place.name.lowercased() == placeName.lowercased() {
                return true
            }
        }
        return false
    }
}

