//
//  StuffContentView.swift
//  MentalUnload
//
//  Created by Dagmar Feldt on 27.07.24.
//  refactored and commented 03.08.24



import SwiftUI
import SwiftData


/** The Central View of Stuff (Kram-App)....parent of AddItemView, EditItemView and ItemDetailView...and PlacesView with EditPlacesView and AddPlacesView
    Provides a Searchable to then display the findings in a NavigationStack where you can edit or delete with a swipe or tap to get directed into the deatailed View
 
    - Parameters:
        - showStuffView : Bool
   
 */
struct ContentViewStuff: View {
    // Environment
    @Environment(\.modelContext) var context    
    /// CRUD
    // Create
    @State private var showAddItemView = false // sheet to add item
    // Read
    @Query var stuff : [StuffedItem]
    @Query var places : [Place]
    @Query var tags : [Tag]
    @State private var searchText = ""//used to filter the query
    // Update
    @State private var showEditView = false// sheet to edit item
    @State private var editItem = false// alert so that in background itemToEdit is safely created, without this alert, it always get nil transferred to the sheet
    @State var itemToEdit : StuffedItem?//as the sheet cant be inside the foreach the item that has the edit button must be inside this property
    // Delete
    @State var itemToDelete : StuffedItem? //gets the item from the foreach when deleteItem is true
    @State private var deleteItem = false
    @State var filterForTagSelf = false
    @State var tagToFilterSelf : Tag?
    @State private var showUntagged = false
    @State private var showPlaces = false //ShowPlacesView is not a sheet but a view that is part of this view with if... in ZStack, is triggered by showPlaces...tapping on a palce's button shuts ShowPlacesView and returns to ContentView with filtering for items in that place triggerd by the next property (showItemsOfAPlace)
    
    @State var id = 0 // to trigger view to be redrawn
    @State var addNewTag = false
    @State var showAll = false
    var text = "" //dummy text to make nil coalescing possible
    
    private var searchResults: [StuffedItem] {
        if  tagToFilterSelf != nil {
            if let filterTag = tagToFilterSelf {
                return stuff.filter({
                    $0.tag == filterTag
                })
            }
        } else if showUntagged {
            return stuff.filter {
                $0.tag == nil
            }
        } else if showAll {
            return stuff
        }
            let predicate = #Predicate<StuffedItem> { [searchText] item in
                item.name.localizedStandardContains(searchText)
                || item.remarks.localizedStandardContains(searchText) // find all StuffItems that have the searchtext in their name or remarks (places and placedescription not, because that would give to many results that are not specific enough)
            }
            let sortBy = [SortDescriptor(\StuffedItem.name)] //alphabetical by name
            let fetch = FetchDescriptor(predicate: predicate, sortBy: sortBy) // now define fetch
            return try! context.fetch(fetch) // and finally fetch the result
        
    }
    
    
    /*++++++++++++++   BODY  ++++++++++++++++++++*/
    var body: some View {
        
        ZStack { //outer ZStack to have the if showPlaces obove the NavigationStack
            NavigationStack {
                ZStack { //inner ZStack to show the color
                    Color.lightGrey.ignoresSafeArea()
                    VStack(spacing: 0) {
                        if tagToFilterSelf != nil && !showAll {
                            Text("Stuff filtered for \(tagToFilterSelf!.name)").font(.title).padding(.bottom, 0).padding(.horizontal, 5).multilineTextAlignment(.center)
                        } else if showUntagged {
                            Text("Stuff without tag")
                                .font(.title).padding(.bottom, 0).padding(.horizontal, 5)
                        } else if showAll {
                            Text("All my stuff!").font(.title).padding(.bottom, 0).padding(.horizontal, 5)
                        }
                        List {
                            Section {
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
                                                withAnimation {
                                                    context.delete(item)
                                                }
                                            } label: {
                                                Label("Delete", systemImage: "trash.fill")
                                            }
                                        }
                                        
                                    }
                                    
                                }
                            } footer: {
                                if searchResults.count != 0 {
                                    Text("Tap on an item to see its details and swipe to the left to edit or delete it.")
                                }
                            }
                        } // List
                        .listRowSpacing(4)
                        .id(id)
                        .scrollContentBackground(.hidden) //lets the ZSTack Color through the List background, has no Color as option, only visibilty
                        
                        
                        
                    }
                    .task { // onAppear dummy value for itemToEdit, otherwise it crashed for some reason
                        itemToEdit = StuffedItem(name: "Test", place: Place(name: "house"))
                    }
                    
                    .alert("edit", isPresented: $editItem, actions: {
                        Button("Okay", role: .destructive) {
                            showEditView = true
                        }
                    }) // sort of step between going to editview and leaving content view, for some reason it didnt gave itemToEdit the correct value without this step...?
                    .sheet(isPresented: $showAddItemView, content: {
                        AddItemView(id: $id, tagForItem: tagToFilterSelf)
                            .colorScheme(.light)
                    })
                    .sheet(isPresented: $showEditView, content: {
                        if itemToEdit != nil { //there should be a value but just to be very sure
                            EditItemView(item: itemToEdit!).colorScheme(.light)
                        }
                    })
                    .sheet(isPresented: $addNewTag, content: {
                        AddNewTagFromCheckList(showAddTag: $addNewTag, tagForChecklist: $tagToFilterSelf ).presentationDetents([.small,.medium])
                    })
                    
                    .toolbar {
                        
                        ToolbarItem(placement: .topBarTrailing, content: {
                            Menu("\(Image(systemName: "tag"))", content: {
                                Section {
                                    Menu("TAGS") {
                                        ForEach(tags) { tag in
                                            Button {
                                                showAll = false
                                                tagToFilterSelf = tag
                                            } label: {
                                                Text(tag.name)
                                            }
                                        }
                                    }
                                
                                    Section {
                                        Button("Show all") {
                                            showUntagged = false
                                            tagToFilterSelf = nil
                                            showAll = true
                                            
                                        }
                                        Button("Not tagged") {
                                            showAll = false
                                            tagToFilterSelf = nil
                                            showUntagged = true
                                            
                                        }
                                    }
                                }
                                Section {
                                    Button("Add new tag") {
                                        addNewTag = true
                                    }
                                }
                            })
                        })
                                   
                        ToolbarItem(placement: .topBarTrailing, content: {
                            Button {
                                showAll = false
                                tagToFilterSelf = nil
                                showPlaces = true
                            } label: {
                                Label("Places", systemImage: "archivebox")
                            }
                        })
                        ToolbarItem(placement: .topBarTrailing, content: {
                            Button {
                                showAddItemView = true
                            } label: {
                                Label("Add", systemImage: "plus")
                            }
                        })
                    }
                } //inner ZStack
                
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .navigationTitle("Store Stuff")
                .searchable(text: $searchText)
                .overlay(content: {
                    if searchResults.count == 0 {
                        customUnavailableView()
                    }
                })
                .onChange(of: searchText, {
                    showAll = false
                })
                
            } // Navigationstack
            .navigationDestination(isPresented: $showPlaces, destination: {
                PlacesView()
            })
        
        } // outer ZStack
        
        
    } // body
    
    func searchTextIsEmpty() -> Bool {
        return searchText == ""
    } // obvious
    
    func customUnavailableView() -> some View {
        if searchTextIsEmpty() &&  tagToFilterSelf == nil {
            return ContentUnavailableView("What are you looking for?", systemImage: "magnifyingglass", description: Text("Enter searchtext or use buttons for tags and places at the top of the screen.\nUse plus button to store new item."))
        } else if stuff.isEmpty {
            return ContentUnavailableView("No stored items!", systemImage: "archivebox", description: Text("Use plus button to store an item."))
        } else if tagToFilterSelf != nil {
            return ContentUnavailableView("No items for \(tagToFilterSelf!.name)", systemImage: "magnifyingglass", description: Text("Add item with the plus button"))
        }
        return ContentUnavailableView("No searchresults", systemImage: "magnifyingglass", description: Text("Try another text or add item with the plus button"))
    }
} // ContentVoew
    

