//
//  ResteKiste.swift
//  MentalUnload
//
//  Created by Dagmar Feldt on 06.08.24.
//

import Foundation

//
//
//            NavigationStack {
//                ZStack {
//                    Color.lightGrey.ignoresSafeArea()
//
//                ScrollView {
//                    VStack {
//                        Button("Show items with no places") {
//                           showItemsWithNoPlaces = true
//                            showPlaces = false
//                        }.padding(.bottom, 20)
//
//                        ForEach(places) { place in
//                            Button {
//                                showItemsOfPlace = true
//                                placeToShowItsItems = place
//                                showPlaces = false
//                            } label: {
//                                PlaceButtonLabel(place: place, placeToEdit: $placeToEdit, placeToDelete: $placeToDelete, editPlace: $editPlace, deletePlace: $deletePlace)
//                                .frame(maxWidth: .infinity, maxHeight: 80)}
//                            .sheet(isPresented: $showEditPlace, content: {
//                                if placeToEdit != nil {
//                                    EditPlaceView(place: placeToEdit!).colorScheme(.light).presentationDetents([.medium])
//                                }
//                            })
//                        }
//
//
//                    }
//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
//
//                    .alert("delte", isPresented: $deletePlace, actions: {
//                        Button("del", role: .destructive) {
//                            context.delete(placeToDelete!)
//                            placeToDelete = nil
//                        }
//                    })
//                    .navigationTitle("My Places")
//                        .padding()
//                        .task {
//                            placeToEdit = Place(name: "Hause")
//                        }
//                        .alert("edit", isPresented: $editPlace, actions: {
//                            Button("Okay", role: .destructive) {
//                                showEditPlace = true
//                            }
//                        })
//                        .sheet(isPresented: $showAddPlaceView, content: {
//                            AddPlaceView(showAddPlace: $showAddPlaceView, addNewPlace: $newPlaceAdded).preferredColorScheme(.light).presentationDetents([.medium])
//                        })
//                    .toolbar {
//                        ToolbarItem(placement: .topBarLeading, content: {
//                            Button {
//                                showPlaces = false
//                            } label: {
//                                Label("back", systemImage: "chevron.left")
//                            }
//                        })
//                        ToolbarItem(placement: .topBarTrailing, content: {
//                            Button {
//                                showAddPlaceView = true
//                            } label: {
//                                Label("Add", systemImage: "plus")
//                            }
//                        })
//                    }
//                }
//            }.overlay(content: {
//                if places.count == 0 {
//                    ContentUnavailableView("No places found", systemImage: "archivebox", description: Text("You can add places with the Add-Button"))
//
//                }
//            })
//
//
//        }
