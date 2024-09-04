//
//  ContentViewMemorySupport.swift
//  MentalUnload
//
//  Created by Dagmar Feldt on 28.07.24.
//



import SwiftUI
import SwiftData
struct ContentViewMemorySupport: View {

    @Environment(\.modelContext) var context
    @Query(sort: \Memory.date, order: .reverse) var memories : [Memory]
    @Query var tags : [Tag]
    @State private var showAddMemory = false
    @State private var searchText = ""
    @State private var showOpenTasks = false
    @State private var showEditAlert = false
    @State private var showEditView = false
    @State private var memoryToDelete : Memory?
    @State private var memoryToEdit : Memory?
    @State private var showAllMemories = false
    @State private var filterOpenTask = false
    @State private var filteredOpenTasks = [Memory]()
    @State private var linkFromDetail = false
    @State private var showUntagged = false
    @State private var addNewTag = false
    
    @State var tagToFilter : Tag?
    
    private var openTasksResults : [Memory] {
        var memoriesWithOpenTasks : [Memory] = []
        for item in memories {
            if item.numberOfOpenTasks() > 0 {
                memoriesWithOpenTasks.append(item)
            }
        }
        memoriesWithOpenTasks.sort {
            $0.numberOfOpenTasks() > $1.numberOfOpenTasks()
        }
        return memoriesWithOpenTasks
    }
    private var memoriesForTag : [Memory] {
        var memoriesForTag = [Memory]()
        for memory in memories {
            if memory.tag == tagToFilter {
                memoriesForTag.append(memory)
            }
        }
        return memoriesForTag
    }
    private var searchResults : [Memory] {
        var fetch = FetchDescriptor<Memory>()
        let predicate = #Predicate<Memory> { [searchText] item in
            item.title.localizedStandardContains(searchText)
            || item.descriptionText.localizedStandardContains(searchText)
            || item.conclusion.localizedStandardContains(searchText)
        }
        let sortBy = [SortDescriptor(\Memory.date, order: .reverse)]
        fetch = FetchDescriptor(predicate: predicate, sortBy: sortBy)
        return try! context.fetch(fetch)
    }
    var body: some View {
        NavigationStack {
            ZStack {
                Color.lightGrey.ignoresSafeArea()
                VStack {
                    Text(textForHeadline()).font(.title2)
                    List{
                        ForEach(memoriesToShow()) { memory in
                            NavigationLink {
                                MemoryDetailView(memory: memory)
                            } label: {
                                ZStack {
                                    Rectangle().fill(Color.ocean)
                                    Text(memory.title).font(.title2).badge(memory.numberOfOpenTasks()).foregroundStyle(.white)
                                        .padding()
                                }
                            }
                            .listRowBackground(Color.ocean)
                            .swipeActions(allowsFullSwipe: false) {
                                Button {
                                    memoryToEdit = memory
                                    showEditAlert = true
                                } label: {
                                    Label("Edit", systemImage: "pencil")
                                }
                                .tint(.indigo)
                                
                                Button(role: .destructive) {
                                    context.delete(memory)
                                } label: {
                                    Label("Delete", systemImage: "trash.fill")
                                }
                            }
                            
                            
                            
                        }
                        
                    }.searchable(text: $searchText)
                        .listRowSpacing(6)
                        .scrollContentBackground(.hidden)
                    
                    
                }
            }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing, content: {
                        Menu("\(Image(systemName: "tag"))", content: {
                            Section {
                                Menu("TAGS") {
                                    ForEach(tags) { tag in
                                        Button {
                                            showUntagged = false
                                            showAllMemories = false
                                            tagToFilter = tag
                                        } label: {
                                            Text(tag.name)
                                        }
                                    }
                                }
                            
                                Section {
                                    Button("Not tagged") {
                                        showAllMemories = false
                                        tagToFilter = nil
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


                    ToolbarItem(placement: .topBarTrailing) {
                        Menu("\(Image(systemName: "line.3.horizontal.decrease.circle"))") {
                            Button {
                                showAllMemories = true
                                filterOpenTask = false
                            } label: {
                                Label("Show all", systemImage: "square.stack")
                            }
                            Button {
                                showAllMemories = false
                                showOpenTasks = true
                                
                            } label: {
                                Label("Show unfinished Tasks",systemImage: showOpenTasks ? "exclamationmark.square.fill" : "exclamationmark.square")
                            }
                        }
                    }
                    ToolbarItem(placement: .topBarTrailing, content: {
                        Button {
                            showAddMemory = true
                        } label: {
                            Label("Add", systemImage: "plus")
                        }
                    })
                }
            
                .navigationTitle("Memory Support")
            
                .alert("Edit memory?",isPresented: $showEditAlert) {
                    Button("cancel", role: .cancel) {}
                    Button("okay") {
                        showEditView = true
                    }
                }
                .sheet(isPresented: $showAddMemory, content: {
                    AddMemoryView()
                })
                .sheet(isPresented: $showEditView, content: {
                    EditMemoryView(memory: memoryToEdit!, linkFromDetail: $linkFromDetail, showEditView: $showEditView)
                })
            
                .overlay {
                    if memoriesToShow().count == 0 {
                        ContentUnavailableView(contentUnavailableTitle(), systemImage: contentUnavailableImage(), description: Text(contentUnavailableDescription()))
                    }
                }
                .task {
                    
                }
                .onChange(of: searchText) {
                    showAllMemories = false
                    showOpenTasks = false
                }
        }
    }
    func showContentUnavailable() -> Bool {
        if showOpenTasks  {
            if openTasksResults.count == 0 {
                return true
            } else {
                return false
            }
        }
        else if showAllMemories {
            if memories.count == 0 {
                return true
            } else {
                return false
            }
        }
        else if searchResults.count == 0 {
            return true
        }
        return false
    }
    
    func contentUnavailableTitle() -> String {
        if showOpenTasks && openTasksResults.count == 0 {
            return "No unfinished task found "
        } else if searchText != "" && searchResults.count == 0 {
            return "No matching memos found"
        } else if showAllMemories {
            return "No memories available!"
        } else {
            return "Enter text to search for memos."
        }
    }
    
    func contentUnavailableImage() -> String {
        if showOpenTasks && openTasksResults.count == 0 {
            return "sun.max"
        } else {
            return "magnifyingglass"
        }
    }
    
    func contentUnavailableDescription() -> String {
        if showOpenTasks && openTasksResults.count == 0 {
            return "Congratulations!\nYou can add memos (with tasks) with the add button"
        } else if searchText != "" && searchResults.count == 0 {
            return "Try a different search text.\nThe search browses the title, description and conclusion of the memos."
        } else  {
            return "To find memos you have to create some first, use the add button to do so."
        }
    }
    
    func memoriesToShow() -> [Memory] {
        if searchText != "" {
            return searchResults
        }
        if showAllMemories {
            return memories
        } else if showOpenTasks {
            return openTasksResults
        } else if showUntagged {
            return memories.filter {
                $0.tag == nil
            }
        } else if tagToFilter != nil {
            return memoriesForTag
        }
        return searchResults
    }
    
    func textForHeadline() -> String {
        if searchText != "" {
            return "Search results"
        }
        if showAllMemories {
            return "All stored memories"
        } else if showOpenTasks {
            return "Memories with unfinished task"
        } else if showUntagged {
            return "Memories without a tag"
        } else if tagToFilter != nil {
            return "Filtered for \(tagToFilter!.name)"
        }
        return ""
    }
}




