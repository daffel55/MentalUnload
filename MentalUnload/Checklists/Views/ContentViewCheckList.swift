//
//  ContentViewCheckList.swift
//  MentalUnload
//
//  Created by Dagmar Feldt on 28.07.24.
//



import SwiftUI
import SwiftData

import TipKit

struct ContentViewCheckList: View {
    @AppStorage("firstUse") var firstUse = true
    @Environment(\.modelContext) private var context
    @Query private var checkLists : [CheckListModel]
    @Query private var tags : [Tag]
    @State private var addNewCheckList = false
    @State private var deleteCheckList = false
    @State private var itemToDelete : CheckListModel?
    @State private var showEditView = false
    @State private var showTheEditView = false
    @State private var addNewTag = false
    @State private var tagToDelete : Tag?
    @State  var tagToEdit : Tag?
    @State private var deleteTag = false
    @State private var showTagEdit = false
    @State private var checkListToEdit: CheckListModel?
    @State private var showInfo = false
    let language = NSLocale.current.identifier
    @State private var id = 0
    @State  var tagToFilter : Tag?
    var filterTag : Tag?
    @State private var showUntagged = false
    @State private var addChecklistsHere = false
    let firstTip = FirstTipCheckList()
    var filteredCheckLists : [CheckListModel] {
        if let tag = tagToFilter {
            return tag.checklists
        } else if showUntagged {
            var untaggedList = [CheckListModel]()
            for list in checkLists {
                if list.tag == nil {
                    untaggedList.append(list)
                }
            }
            return untaggedList
        }
        return checkLists
    }
    
    var listTitle : String {
        if let tag = tagToFilter {
            return "Filtered for \(tag.name)"
        }  else if showUntagged {
            return "Checklist without a tag"
        }
        else {
            return "Unfiltered"
        }
    }
    
    var sortedTags : [Tag] {
        tags.sorted(by: {$0.name < $1.name})
    }
    var body: some View {
        ZStack {
            NavigationStack {
                ZStack {
                    Color.lightGrey.ignoresSafeArea()
                    VStack {
                        Text(listTitle).font(.title2).foregroundStyle(.black.opacity(0.8))
                        List {
                            Section {
                                ForEach(filteredCheckLists) { checkList in
                                    NavigationLink {
                                        CheckListDetailView(checkList: checkList)
                                    } label: {
                                        Text(checkList.title).font(.title2).padding(5).foregroundStyle(checkList.fontColor)
                                    }.listRowBackground(Color(hex: checkList.color))
                                        .swipeActions(allowsFullSwipe: false) {
                                            Button {
                                                checkListToEdit = checkList
                                                showEditView = true
                                            } label: {
                                                Label("edit", systemImage: "pencil").tint(.indigo)
                                            }
                                            Button(role: .destructive) {
                                                withAnimation {context.delete(checkList)}
                                            } label: {
                                                Label("Delete", systemImage: "trash.fill")
                                            }
                                        }
                                    
                                }
                            }
                        } // List
                        .scrollContentBackground(.hidden)
                            if isFilteredForTag() {
                                Section {
                                    Button {
                                        addChecklistsHere = true
                                    } label: {
                                        Text("Add existing checklists to this tag")
                                    }.buttonStyle(.borderedProminent)
                                    Text("To add a new checklist to this tag, hit the plus button").font(.caption)
                                }
                            }
                            
                            
                            
                            
                       
                    }
                   .navigationTitle("Checklists")
                    .listRowSpacing(6)
                    .scrollContentBackground(.hidden)
                    .padding()
                    .frameForIPad(active: ScreenMessurement.isIPadInLandscape)
                    .toolbar {

                        ToolbarItem {
                            
                            Menu("\(Image(systemName: "tag"))", content: {
                              
                                
                                Section {
                                    Menu("TAGS") {
                                        ForEach(sortedTags) { tag in
                                            Button {
                                                showUntagged = false
                                                tagToFilter = tag
                                            } label: {
                                                Text(tag.name)
                                            }
                                        }
                                    }
                                }
                                Section {
                                    Button("Show all") {
                                        showUntagged = false
                                        tagToFilter = nil
                                    }
                                    Button("Not tagged") {
                                        tagToFilter = nil
                                       showUntagged = true
                                        
                                    }
                                }
                                Section {
                                    Button("Add new tag") {
                                        addNewTag = true
                                    }
                                }
                            })
                        }
                        
                        ToolbarItem(placement: .topBarTrailing, content: {
                            Button("", systemImage: "plus") {
                                
                                    addNewCheckList = true
                                
                            }.padding()
                        })
//
                    }
                    .sheet(isPresented: $addChecklistsHere, content: {
                        
                        AddUntaggedChecklists(tag: tagToFilter!)
                    })
                    .sheet(isPresented: $addNewCheckList) {
                        if let tag = tagToFilter {
                            AddCheckListToExistingTag(tag: tag)
                        } else {
                            AddCheckListView()
                        }
                    }
                    .sheet(isPresented: $addNewTag, content: {
                        AddNewTagFromCheckList(showAddTag: $addNewTag, tagForChecklist: $tagToFilter ).presentationDetents([.small,.medium])
                    })

                    .sheet(isPresented: $showTheEditView, content: {
                        EditCheckListView(checkList: checkListToEdit!)
                    })
                    .sheet(isPresented: $showInfo, content: {
                        if language.hasPrefix("de") {
                            InfoView()
                        } else {
                            InfoViewEnglish()
                        }
                        
                    })
                    .alert("edit", isPresented: $showEditView, actions: {
                        Button("Okay", role: .destructive) {
                            showTheEditView = true
                        }
                    })
                 }
                         }
        }
        .overlay(content: {
            if checkLists.isEmpty {
                unavailableView
            }
        })
        .task {
            if firstUse {
                context.insert(checkListTag)
                if language.hasPrefix("de") {
                    
                    context.insert(checkListWohnwagenVerlassen)
                    context.insert(checkListWohnwagenAb)
                    context.insert(checkListWohnwagenAn)
                    context.insert(checkListDemo)
                } else {
                    context.insert(checkListCaravanHitched)
                    context.insert(leaveCaravanAlone)
                    context.insert(checkListCaravanUnhitched)
                    context.insert(checkListDemoEnglsh)
                }
                
                firstUse = false
                tagToEdit = Tag(name: "test")
            }
            if filterTag != nil {
                tagToFilter = filterTag
            }
        }
        
    }
        var unavailableView : some View {
            
            ContentUnavailableView("noCheck", systemImage: "list.bullet.clipboard", description: Text("\(addListWithIcon) \(Image(systemName: "text.badge.plus"))").font(.title2).foregroundStyle(.black))
        }
        
        var addListWithIcon : String {
            if language.hasPrefix("de") {
                return "Erstelle eine neue Checkliste mit"
            } else {
                return "Add a list with the add-list-symbol"
            }
        }
    
    func isFilteredForTag() -> Bool {
        if tagToFilter != nil {
                return true
            }
        return false
    }
        
    
}

struct CheckListButtonLabel : View {
    var checkList : CheckListModel
    //@Binding var checkListToEdit : CheckListModel
    @Binding var itemToDelete : CheckListModel?
    @Binding var checkListToEdit : CheckListModel?
    @Binding var editCheckList : Bool
    @Binding var deleteCheckList : Bool
    
    var body: some View {
        ZStack(alignment: .leading){
            Rectangle().fill(Color(hex: checkList.color))
                .shadow(radius: 6)
            
            
            
                
                Text(checkList.title).font(.title2)
                    .foregroundStyle(checkList.color == 0xFFFFFF ? .black : .white)
                    .multilineTextAlignment(.leading)
                    .padding()
   
            }
            
        
        
        .foregroundColor(.white)
        .padding(.horizontal, 20)
        .frameForIPad(active: ScreenMessurement.isIPadInLandscape)
    }
}


struct SectionTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.gray)
            .font(.title2)
            .fontWeight(.light)
            .textCase(.uppercase)
            .padding(.leading, 20)
    }
}

extension View {
    func sectionTitle() -> some View {
        modifier(SectionTitle())
    }
}

