//
//  AddCheckListToExistingTag.swift
//  MentalUnload
//
//  Created by Dagmar Feldt on 28.07.24.
//


import SwiftUI
import SwiftData
struct AddCheckListToExistingTag: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    var tag : Tag?
    
    @State private var checkListTitle: String = ""
    @State private var checkListItems  = [CheckListItem]()
    @State private var item = ""
    @State private var itemCount = 1
    @State private var colorValue : Int = colorInts[0]
    @State private var tagForChecklist : Tag?
    @State private var titlePlaceholder = NSLocalizedString("addChec", comment: "")
    @State private var itemPlaceHolder = NSLocalizedString("addItem", comment: "")
    var body: some View {
        NavigationStack {
            
            Form {
                Section("checkListName") {
                    TextField(titlePlaceholder, text: $checkListTitle)
                }
                Section("checkListItems") {
                    ForEach(0..<checkListItems.count, id: \.self) { count in
                        
                        if !checkListItems.isEmpty {
                            Text(checkListItems[count].name)
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
                
                Section("pickCol") {
                    HStack {
                        ForEach(colorInts, id: \.self) { color in
                            Rectangle().fill(Color(hex: color)).frame(width: 20, height: 20).cornerRadius(8).border(colorValue == color ? .black : .white, width: 1)
                                .onTapGesture {
                                    colorValue = color
                                }
                        }
                        
                        Rectangle().fill(Color.white).frame(width: 20, height: 20).cornerRadius(8).border(colorValue == 0xFFFFFF ? .black : .white, width: 1)
                            .onTapGesture {
                                colorValue = 0xFFFFFF
                            }
                        Rectangle().fill(Color.black).frame(width: 20, height: 20).cornerRadius(8).border(colorValue == 0x000000 ? .black : .white, width: 1)
                            .onTapGesture {
                                colorValue = 0x000000
                            }
                        
                    }
                }
                HStack {
                    Button("canc") {
                        dismiss()
                    }
                    Spacer()
                    Button {
                        if item != "" {
                            checkListItems.append(CheckListItem(name: item))
                        }
                        if checkListTitle.isEmpty {
                            titlePlaceholder = NSLocalizedString("listMustName", comment: "")
                        }
                        else if checkListItems.isEmpty {
                            itemPlaceHolder = NSLocalizedString("enterItem", comment: "")
                        } else {
                            
                            let checkList = CheckListModel(title: checkListTitle, items: checkListItems, colorValue: colorValue, tag: tag)
                            context.insert(checkList)
                            dismiss()
                        }
                        
                    } label: {
                        Text("sav")
                    }.buttonStyle(.borderedProminent)
                }
                
            }.navigationTitle(NSLocalizedString("AddNewListTo", comment: "") + tag!.name)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}


