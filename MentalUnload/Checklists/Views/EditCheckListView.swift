//
//  EditCheckListView.swift
//  MentalUnload
//
//  Created by Dagmar Feldt on 28.07.24.
//




import SwiftUI
import SwiftData

struct EditCheckListView: View {
    var checkList : CheckListModel?
    @Environment(\.dismiss) private var dismiss
    @Query var tags: [Tag]
    @State private var tagForCheckList : Tag?
    @State private var checkListTitle: String = ""
    @State private var checkListItems  = [CheckListItem]()
    @State private var item = ""
    @State private var itemCount = 1
    @State private var colorValue : Int = colorInts[0]
    @State private var titlePlaceholder = NSLocalizedString("addChec", comment: "")
    @State private var itemPlaceHolder = NSLocalizedString("addItem", comment: "")
    @State private var showRemoveAlert = false
    @State private var showAddTag = false

    var body: some View {
        NavigationStack {
            ZStack {
                Form{
                    Section("checkListName") {
                        TextField(checkListTitle, text: $checkListTitle)
                    }
                    Section("checkListItems") {
                        ForEach(0..<checkListItems.count, id: \.self) { count in
                            
                            if !checkListItems.isEmpty {
                                HStack{
                                    TextField(checkListItems[count].name,text: $checkListItems[count].name)
                                    if checkListItems.count > 1 {
                                        Button(action: {
                                            if checkListItems.count > 1 {
                                                checkListItems.remove(at: count)
                                            }
                                            if checkListItems.count == 1 {
                                                showRemoveAlert = true
                                            }
                                        }, label: {
                                            Image(systemName: "trash")
                                        })
                                    }
                                }
                            }
                        }
                        
                        HStack {
                            TextField(itemPlaceHolder,text: $item)
                            
                            Button(action: {
                                if !item.isEmpty {
                                    checkListItems.append(CheckListItem(name: item))
                                    item = ""
                                }
                            }, label: {
                                Image(systemName: "plus")
                            })
                        }
                        
                        
                    }
                    Section("Tag") {
                        Picker("\(Image(systemName: "tag"))", selection: $tagForCheckList, content: {
                            Text("No tag")
                                .tag(Optional<Tag>(nil))
                            ForEach(tags) { tag in
                                Text(tag.name).tag(tag as Tag?)
                            }
                            
                        }).padding(.trailing, 100)
                        Button("Add new tag") {
                            showAddTag = true
                        }
                    }
                    Section("pickCol") {
                        HStack {
                            ForEach(colorInts, id: \.self) { color in
                                Rectangle().fill(Color(hex: color)).frame(width: 20, height: 20).cornerRadius(8).border(colorValue == color ? .white : .black, width: 1)
                                    .onTapGesture {
                                        colorValue = color
                                    }
                            }
                            
                            Rectangle().fill(Color.white).frame(width: 20, height: 20).cornerRadius(8).border(.black, width: 1)
                                .onTapGesture {
                                    colorValue = 0xFFFFFF
                                }
                            Rectangle().fill(Color.black).frame(width: 20, height: 20).cornerRadius(8).border(.black, width: 1)
                                .onTapGesture {
                                    colorValue = 0x000000
                                }
                        }
                    }
                }
            }
            .navigationTitle("Edit Checklist")
            .toolbar {
                ToolbarItem(placement: .topBarLeading, content: {
                    Button("Cancel") {
                        dismiss()
                    }
                })
                ToolbarItem(placement: .topBarTrailing, content: {
                    Button("Save") {
                        if item != "" {
                            checkListItems.append(CheckListItem(name: item))
                        }
                        checkList!.title = checkListTitle
                        checkList!.items = checkListItems
                        checkList!.tag = tagForCheckList
                        checkList!.color = colorValue
                        dismiss()
                        
                    }
                })
            }
        }
        .task {
            checkListTitle = checkList!.title
            checkListItems = checkList!.items
            colorValue = checkList!.color
            tagForCheckList = checkList!.tag
        }
        .alert(NSLocalizedString("notAllEntries", comment: ""), isPresented: $showRemoveAlert, actions: {
            Button("Okay", role: .cancel) {
                
            }
        })
        .sheet(isPresented: $showAddTag, content: {
            AddNewTagFromCheckList(showAddTag: $showAddTag, tagForChecklist: $tagForCheckList).presentationDetents([.small, .medium])
        })
        
    }
}

