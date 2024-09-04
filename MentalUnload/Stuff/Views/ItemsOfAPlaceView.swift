//
//  ItemsOfAPlaceView.swift
//  MentalUnload
//
//  Created by Dagmar Feldt on 06.08.24.
//  Refactored and commented 08.08.24




import SwiftUI
import SwiftData

/**
 Shows a list of items that are in one place (Child from PlacesView)
 - Parameters: 
    - showItemsOfAPlace (if true it filters for items without a palce, default is false)
    - placeThatHoldsItems : Place?
 
 */
struct ItemsOfAPlaceView: View {
    //Environment
    @Environment(\.modelContext) var context
    
    
    /* +++++++++++++ CRUD ++++++++++++*/
    // Create
    @State private var showAddItemView = false // sheet to add item
    // Read
    @Query var stuff : [StuffedItem]
    var placeThatHoldsItems : Place? // will be filled by PlacesView to filter for this place
    private var searchResults: [StuffedItem] {
        if placeThatHoldsItems != nil {
            return placeThatHoldsItems!.stuff ?? []
        }
        else  { //filter all query results for stuuf that has no place
            return stuff.filter {
                $0.place == nil
            }
        }
    }
    //Update
    @State var itemToEdit : StuffedItem?
    @State private var editItem = false
    @State private var showEditView = false
    
    // delete Item
    // I decided to do without a delete alert here, because you already made a swipeaction and pressed the button to delete
    
    
    @State var id = 0 //to redraw view

    /*++++++++++++++   BODY  ++++++++++++++++++++*/
    var body: some View {
        
        ZStack { //outer ZStack to have the if showPlaces obove the NavigationStack
            NavigationStack {
                ZStack { //inner ZStack to show the color
                    Color.lightGrey.ignoresSafeArea()
                    List {
                        ForEach(searchResults) { item in
                            Section {
                                NavigationLink (destination: ItemDetailView(item: item, id: $id), label: {
                                        Text(item.name)
                                        .font(.title2)
                                        .padding(5)
                                        .foregroundStyle(.white)
                                })
                                .listRowBackground(Color.ocean)
                                .swipeActions(allowsFullSwipe: false) {
                                    Button {
                                        itemToEdit = item // stores this item into itmToEdit
                                        editItem = true // triggers alert for ShowEdit
                                    } label: {
                                        Label("Edit", systemImage: "pencil")
                                    }
                                    .tint(.indigo)
                                    
                                    Button(role: .destructive) {
                                        context.delete(item) // deletes the item without alert
                                    } label: {
                                        Label("Delete", systemImage: "trash.fill")
                                    }
                                }
                            }
                            .listSectionSpacing(3)
                        }
                    } // List
                    .scrollContentBackground(.hidden) //lets the ZSTack Color through the List background, has no Color as option, only visibilty
                    .padding()
                } //inner ZStack
                .frame(maxWidth: .infinity)
                .navigationTitle(isItemWithoutPlace() ? "Items with no place" : "Items stored at \(placeThatHoldsItems!.name)")
                .overlay(content: { // ContentUnavailableViews depending on what should be seen here
                    if searchResults.count == 0 {
                        ContentUnavailableView(isItemWithoutPlace() ? "All stuff is stored to a place" : "No items found for \(placeThatHoldsItems!.name)", systemImage: isItemWithoutPlace() ? "archivebox.fill" : "archivebox", description: Text("You can add items with the plus button"))
                    }
                })
                .alert("Edit item?", isPresented: $editItem, actions: {
                    Button("Edit", role: .destructive) {
                        showEditView = true
                    }
                })
            } // Navigationstack
        } // outer ZStack
        .sheet(isPresented: $showEditView, content: {
            EditItemView(item: itemToEdit!)
        })
        .sheet(isPresented: $showAddItemView, content: {
            AddItemView(id: $id, placeForItem: placeThatHoldsItems ?? nil)// place should be set to the place from where the user decided to add another item
        })
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                   showAddItemView = true
                } label: {
                    Label("Add", systemImage: "plus")
                }
            }
        }
    } // body
    func isItemWithoutPlace() -> Bool {
        return placeThatHoldsItems == nil
    }
}
 
