//
//  PlacesView.swift
//  MentalUnload
//
//  Created by Dagmar Feldt on 07.08.24.
//  Refactored and commented 08.08.24

import SwiftUI
import SwiftData

/** View that shows all places the user added before and gives the opportunity to add, edit and delete a place
 The user can also see what is stored at a single place
 - Parameters:
 - showPlaces: Bool (go back to calling View)
 */
struct PlacesView: View {
    // Environment
    @Environment(\.modelContext) var context
    // Binding
//    @Binding var showPlaces : Bool
    
    /* ++++++++++++ CRUD ++++++++++++*/
    // Create
    @State var addPlace = false
    // Read
    @Query var places : [Place]
    // Update
    @State var showEditPlaceAlert = false
    @State var showEditPlace = false
    @State var placeToEdit : Place?
    // Delete
    @State var deletePlace = false
    @State var placeToDelete : Place?
    
    // Manage views
    var dummyPlace = Place(name: "dummy")
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.lightGrey.ignoresSafeArea()
                List {
                    
                    Section {
                        ForEach(places) { place in
                            Section {
                                NavigationLink(destination: {
                                    ItemsOfAPlaceView(placeThatHoldsItems: place)
                                }, label: {
                                    Text(place.name)
                                        .font(.title2)
                                        .padding(.bottom, 10)
                                        .foregroundStyle(.black)
                                })
                                .listRowBackground(Color.colorForPlace) // wanted it different from items
                                .swipeActions(content: {
                                    Button {
                                        placeToEdit = place
                                        showEditPlaceAlert = true
                                    } label: {
                                        Label("Edit", systemImage: "pencil")
                                    }.tint(.indigo)
                                    Button {
                                        placeToDelete = place
                                        deletePlace = true
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }.tint(.red)
                                })
                                
                            }
                            
                            
                        }
                    } footer: {
                        Text("Tap on a place to see all its stored items and swipe to the left to edit or delete it.")
                    }
                    Section {
                        NavigationLink(destination: {
                            ItemsOfAPlaceView(placeThatHoldsItems: nil ) // as there is no place for those items
                        }, label: {
                            Text("Items without an assigned place")
                                .font(.title2)
                                .padding(5)
                                .foregroundStyle(.colorForPlace)
                                
                            
                        }).listRowBackground(Color.black.opacity(0.6))
                    }
                } // List
                .listRowSpacing(4)
                
            } // ZStack
            .navigationTitle("Places")
            .toolbar {
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        addPlace = true
                    } label: {
                        Label("Add", systemImage: "plus")
                    }
                }
            }
            .alert("Edit place?", isPresented: $showEditPlaceAlert, actions: {
                Button("Cancel", role: .cancel) {}
                Button("okay") {
                    showEditPlace = true
                }
            })
            .alert("Delete Place?", isPresented: $deletePlace, actions: {
                Button("Cancel", role: .cancel) {}
                Button("Delete",role: .destructive) {
                    context.delete(placeToDelete!)
                }
            })
            .sheet(isPresented: $showEditPlace, content: {
                EditPlaceView(place: placeToEdit!)
                    .presentationDetents([.medium]) // as there is not much to show, the sheet will only take half of the screen
            })
            .sheet(isPresented: $addPlace, content: {
                AddPlaceView()
                    .presentationDetents([.medium]) // see above
            })
            
        } // Navigationstack
    }// body
}

