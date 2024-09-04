//
//  MemoryDetailView.swift
//  MentalUnload
//
//  Created by Dagmar Feldt on 28.07.24.
//



import SwiftUI
import SwiftUIImageViewer

struct MemoryDetailView: View {
    @Environment(\.dismiss) var dismiss
    @State var isImageViewerPresented = false
    @State var showEditView = false
    @State var linkFromDetail = true
    
    
    
    var memory : Memory
    var body: some View {
        ZStack {
            if showEditView {
                EditMemoryView(memory: memory, linkFromDetail: $linkFromDetail, showEditView: $showEditView)
            } else {
                
                NavigationStack {
                    VStack(alignment: .leading, spacing: 20) {
                        Text(memory.title).font(.title)
                        Text(memory.date, style: .date)
                        Text(memory.descriptionText)
                        Text("CONCLUSION:").foregroundStyle(Color.gray)
                        Text(memory.conclusion)
                        if let selectedPhotoData = memory.image,
                           let uiImage = UIImage(data: selectedPhotoData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: .infinity, maxHeight: 200)
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                .onTapGesture {
                                    isImageViewerPresented = true
                                }
                                .fullScreenCover(isPresented: $isImageViewerPresented) {
                                    SwiftUIImageViewer(image: Image(uiImage: uiImage))
                                        .overlay(alignment: .topTrailing){
                                            Button {
                                                isImageViewerPresented = false
                                            } label: {
                                                Image(systemName: "xmark")
                                                    .font(.headline)
                                            }
                                            .buttonStyle(.bordered)
                                            .clipShape(Circle())
                                            .tint(.blue)
                                            .padding()
                                        }
                                }
                        } else {
                            Label("No Image", systemImage: "photo")
                        }
                        Divider()
                        Text(memory.furtherNotice ?  "Further Tasks:" : "No further tasks")
                        ScrollView {
                            VStack(alignment: .leading, spacing: 10) {
                                ForEach(memory.unfinishedTasks) {item in
                                    HStack(alignment: .firstTextBaseline) {
                                        Button {
                                            memory.toggleTaskCheck(item: item)
                                            
                                        } label: {
                                            Image(systemName: item.checked ? "checkmark.square" : "square").foregroundStyle(.secondary)
                                        }
                                        
                                        Text(item.name).strikethrough(item.checked ? true : false, color: .black)
                                        Spacer()
                                    }.padding(.top)
                                }
                            }
                            
                            Spacer()
                        }.padding()
                            .font(.title2)
                            .frame(maxWidth: .infinity)
                        
                        
                    }.navigationTitle("Details")
                        .padding()
                        .toolbar {
                            ToolbarItem(placement: .topBarTrailing) {
                                Button {
                                    showEditView = true
                                } label: {
                                    Label("Edit", systemImage: "pencil")
                                }
                            }
                        }
                        
                    
                }
            }
        }
    }
}





