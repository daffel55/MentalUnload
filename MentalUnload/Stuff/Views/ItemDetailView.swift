//
//  StuffDetailView.swift
//  MentalUnload
//
//  Created by Dagmar Feldt on 27.07.24.
//  Refactored and commented ß5.08.24.


import SwiftUI
import SwiftUIImageViewer
import SwiftData
/// The view that presents the Detail of a StuffItem to the user, linked to EditItemView, child from ContentView
struct ItemDetailView: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    @Bindable var item : StuffedItem //the item to display
    @State var showEditView = false // links to EditItemView
    @State var isImageViewerPresented = false //With help package swiftui-image-viewer display image wit pinch to zoom
    @State private var showDeleteAlert = false
    @Binding var id : Int
    
    var body: some View {
        ZStack {
            NavigationStack {
                ZStack {
                    Color.lightGrey.ignoresSafeArea()
                    Form {
                        Section("What stuff?") {
                            Text(item.name).font(.title)
                        }
                        Section("Where to find") {
                            if let place = item.place {
                                Text(place.name).font(.title2)
                            } else {
                                Text("No place assigned")
                            }
                            Text( item.detailedPlace)
                        }
                        Section("Tag") {
                            Text(item.tag?.name ?? "no tag")
                        }
                        Section("Remarks") {
                            Text(item.remarks)
                        }
                        Section("Image") {
                            // if there are data stored in item.image and these data give an UIImage, show Image
                            if item.hasImage {
                                Image(uiImage: item.viewImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(maxWidth: .infinity, maxHeight: 200)
                                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                    .onTapGesture {
                                        isImageViewerPresented = true
                                    }
                                    .fullScreenCover(isPresented: $isImageViewerPresented) {
                                        SwiftUIImageViewer(image: Image(uiImage: item.viewImage))
                                            .overlay(alignment: .topTrailing){ //close button
                                                Button {
                                                    isImageViewerPresented = false
                                                } label: {
                                                    Image(systemName: "xmark")
                                                        .font(.headline).foregroundStyle(.white)
                                                }
                                                .buttonStyle(.bordered)
                                                .clipShape(Circle())
                                                .padding()
                                            }
                                            .background(.black)
                                        
                                    }
                            } else {
                                Text("No Image available")
                            }
                        
                        }
                    }
                    .foregroundColor(.black)
                    .toolbar{
                        
                        ToolbarItem(placement: .topBarTrailing) {
                            Button {
                                showEditView = true
                            } label: {
                                Label("Edit", systemImage: "pencil")
                            }
                        }
                        ToolbarItem(placement: .topBarTrailing) {
                            Button {
                                showDeleteAlert = true
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                    .alert("Delete this item?", isPresented: $showDeleteAlert, actions: {
                       
                        Button("Delete", role: .destructive) {
                            context.delete(item)
                            id += 1
                            dismiss()
                        }
                    })
                    .sheet(isPresented: $showEditView, content: {
                        EditItemView(item: item).colorScheme(.light)
                    })
                }
            }
        }
    }
}

