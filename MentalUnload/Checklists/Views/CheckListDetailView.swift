//
//  CheckListDetailView.swift
//  MentalUnload
//
//  Created by Dagmar Feldt on 28.07.24.
//


import SwiftUI
import SwiftData

struct CheckListDetailView: View {
    var checkList : CheckListModel
    @State private var showEdit = false
    @State private var count: Int
    @State private var offset: CGFloat = -200.0
    @State private var opacity = 0.0
    @State private var idForEdit = 0
    var soundManager = SoundManager()
    init(checkList: CheckListModel ) {
        self.checkList = checkList
        self.count = checkList.items.count
    }
    var body: some View {
        ZStack(alignment: .top) {
            Color(checkList.allChecked ? Color.greenBackground : Color(hex: checkList.color)).opacity(0.7).ignoresSafeArea()
            Rectangle().fill(Color.lightGrey).frame(maxWidth: .infinity, maxHeight: 100).ignoresSafeArea()
                VStack(alignment: .center, spacing: 10) {
                   
                        Text("allDone")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                            .opacity(opacity)
                            .offset(x: 0, y: -10)
                        Text(checkList.title).font(.title).fontWeight(.bold)
                    
                    ScrollView {
                        VStack(alignment: .leading, spacing: 10) {
                            ForEach(checkList.items) {item in
                                HStack(alignment: .firstTextBaseline) {
                                    Button {
                                        checkList.toggleCheckItem(item: item)
                                        if checkList.allChecked {
                                            withAnimation(.easeOut(duration: 1).repeatForever(autoreverses: false)) {
                                                opacity = 1.0
                                            }
                                            soundManager.playMySound()
                                        } else {
                                            opacity = 0.0
                                        }
                                    } label: {
                                        Image(systemName: item.checked ? "checkmark.square" : "square").foregroundStyle(.black)
                                    }
                                    Text(item.name).strikethrough(item.checked ? true : false, color: .white)
                                }.padding(.top)
                                    .padding(.horizontal, ScreenMessurement.isIPadInLandscape ? 80 : 10)
                            }
                        }
                        
                    Spacer()
                }.padding()
                    .font(.title2)
                    .frame(maxWidth: .infinity)
                    
            }
                .sensoryFeedback(.success, trigger: checkList.allChecked)
           
        }
        
        .toolbar(content: {
            Button {
                checkList.uncheckAll()
                opacity = 0.0
            } label: {
                Label("", systemImage: "arrow.counterclockwise")
            }
            Button {
                showEdit = true
            } label: {
                Label("", systemImage: "pencil")
            }
            
        })
        .sheet(isPresented: $showEdit, content: {
            EditCheckListView(checkList: checkList)
        })
        
            
        
    }
    
}


