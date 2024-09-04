//
//  AddPlaceFromEditItem.swift
//  MentalUnload
//
//  Created by Dagmar Feldt on 09.08.24.
//
//
//  AddPlaceView.swift
//  MentalUnload
//
//  Created by Dagmar Feldt on 27.07.24.
//  Refactored 09.08.24



import SwiftUI
import SwiftData

/// View that add a new place when EditITemView is the parent view
///  - Parameters:
///         - Optional Binding place: Place? ...gets the place the user adds in this view
///         - showAddPlave : Bool ...shows and dismisses this view
///         - newPlaceAddes: Bool ...if user saves the new place it gets true, so the parent view know that there is a new place

struct AddPlaceFromEditItem: View {
    @Environment(\.modelContext) var context
    @Query var places : [Place]
    
    @State private var placeName = ""
    @State private var showNameExistsAlert = false
    @State private var placeMustHaveNameAlert = false
    @State private var borderToRed = false
    
    @Binding var place : Place?
    @Binding var newPlaceAdded : Bool
    @Binding var showAddPlace : Bool
    
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
                            
                        Text("Choose major category places like house, shed, attic or cellar.\nThen specify something like a cupboard, shelf or box in the detailed description field provided in the item's menu.")
                        .padding()
                        .navigationTitle("Add New Place").navigationBarTitleDisplayMode(.inline)
                .toolbar(content: {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Cancel") {
                            showAddPlace = false
                        }
                    }
                    ToolbarItem(placement: .topBarTrailing,content: {
                        Button("Save") {
                            if !placeNameExists() && placeName != ""{
                                let newPlace = Place(name: placeName)
                                
                                context.insert(newPlace)
                                place = newPlace
                                newPlaceAdded = true
                                showAddPlace = false
                                
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

