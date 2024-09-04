//
//  TagsView.swift
//  MentalUnload
//
//  Created by Dagmar Feldt on 20.08.24.
//

import SwiftUI
import SwiftData
struct ContentViewTags: View {
    
    @Environment(\.modelContext) var context
    @Query var tags : [Tag]
    //@Binding var showTagView : Bool
    @State var tagToEdit : Tag?
    @State var showEditTagAlert = false
    @State private var showEditTagView = false
    @State private var showAddTag = false
    @State private var showChecklistsOfTag = false
    @State private var showStuffOfTag = false
    @State private var showMemoriesOfTag = false
    @State private var tagToFilter : Tag?
    
    var body: some View {
        ZStack {
            NavigationStack {
                ZStack {
                    Color.lightGrey.ignoresSafeArea()
                    List {
                        Section {
                            ForEach(tags) { tag in
                                Section {
                                    HStack {
                                        Text(tag.name).font(.title2).padding(5)
                                        Spacer()
                                        createTagButton(tag: tag)
                                    }
                                }
                                .listRowBackground(Color.ocean)
                                
                                .foregroundStyle(.white)
                                .swipeActions(allowsFullSwipe: false) {
                                    Button {
                                        tagToEdit = tag
                                        showEditTagAlert = true
                                    } label: {
                                        Label("", systemImage: "pencil").tint(.indigo)
                                    }
                                    Button(role: .destructive) {
                                        withAnimation {context.delete(tag)}
                                    } label: {
                                        Label("", systemImage: "trash.fill")
                                    }
                                }// swipeactions
                            }// ForEach
                        } footer: {
                            Text("You can edit or delete a tag by swiping its name to the left.")
                        }
                        
                    } // List
                    .listRowSpacing(6)
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing, content: {
                            Button {
                                showAddTag = true
                            } label: {
                                Image(systemName: "plus")
                            }
                        })
                    }
                }
                .navigationTitle("My Tags")
                .alert("Edit Tag?", isPresented: $showEditTagAlert, actions: {
                    Button("Okay", role: .destructive) {
                        showEditTagView = true
                    }
                })
                .sheet(isPresented: $showEditTagView, content: {
                    EditTagView(tag: tagToEdit).presentationDetents([.small,.medium])
                })
                .sheet(isPresented: $showAddTag, content: {
                    AddTag().presentationDetents([.small,.medium])
                })
            }
        } //ZStack
        .navigationDestination(isPresented: $showStuffOfTag, destination: {
            ContentViewStuff(tagToFilterSelf: tagToFilter)
        })
        .navigationDestination(isPresented: $showChecklistsOfTag, destination: {
            ContentViewCheckList(tagToFilter: tagToFilter)
        }) 
        .navigationDestination(isPresented: $showMemoriesOfTag, destination: {
           ContentViewMemorySupport(tagToFilter: tagToFilter)
        })
        
        
        
    }
    
    func createTagButton(tag: Tag) -> some View {
        HStack(spacing: 10) {
            if !tag.stuff.isEmpty {
                Image(systemName: "archivebox")
                    .onTapGesture {
                        tagToFilter = tag
                        showStuffOfTag = true
                    }
            }
            if !tag.checklists.isEmpty {
                Image(systemName: "checkmark.square")
                    .onTapGesture {
                        tagToFilter = tag
                        showChecklistsOfTag = true
                    }
            }
            if !tag.memories.isEmpty {
                Button {
                    tagToFilter = tag
                    showMemoriesOfTag = true
                } label: {
                    Image(systemName: "square.and.pencil")
                }
            }
        }
    }
}

extension PresentationDetent {
    static let small = Self.fraction(0.25)
    static let extraLarge = Self.fraction(0.75)
}

