//
//  AddItemView.swift
//  MentalUnload
//
//  Created by Dagmar Feldt on 27.07.24.
//  refactored and commented 09.08.24


import SwiftUI
import SwiftData
import PhotosUI

struct AddItemView: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    @Query var places : [Place]
    @Query var tags : [Tag]
    @Binding var id : Int // used to redraw
    // all properties of an item are stored in the following properties, and when user presses save written in a new StuffItem
    @State private var name = ""
    @State var placeForItem : Place?
    @State var textEditorChanged = false
    @State private var detailedPlaceDescription : String = ""
    @State private var remarks : String = ""
    @State var tagForItem : Tag?
    @State private var showAddNewPlace = false
    @State private var newPlaceAdded = false
    @State private var selectedPhoto : PhotosPickerItem?
    @State var selectedPhotoData : Data?
    @State private var showNameAlert = false // if user trys to save without providing a name for the item
    @State private var showAddTag = false
    var body: some View {
        ZStack {
            NavigationStack {
                Form {
                    Section("What did you stowed away?") {
                        TextField(showNameAlert ? "You must enter a name" : "Name of item", text: $name).textFieldStyle(.roundedBorder).border(showNameAlert ? Color.red : Color.clear).font(.title)
                        // Save would not work without a name, if user trys to save though, border gets red and placeholder text chenges
                    }
                    Section(content: {
                        Picker("Choose Place", selection: $placeForItem, content: {
                            Text("noFold").tag(Optional<Place>(nil))
                            ForEach(places) { place in
                                Text(place.name).tag(place as Place?)
                            }
                        }).foregroundStyle(.gray)
                        HStack {
                            Text("Or add a new place:").foregroundStyle(.gray.opacity(0.8))
                            Spacer()
                            Button("Add Place") {
                                showAddNewPlace = true
                            }
                        }.padding(.trailing, 10)
                        
                        TextEditor(text:$detailedPlaceDescription) // I chose textEditor so that user can use enter to make a new paragraph
                            .multilineTextAlignment(.leading)
                            .frame(height: 100)
                            .overlay(content: { // placeholder text for TextEditor, cpuldnt find another way
                                if detailedPlaceDescription == "" {
                                    VStack{
                                        HStack {
                                            Text("Detailed Description").foregroundStyle(.gray)
                                            Spacer()
                                        }
                                        Spacer()
                                    }
                                }
                            }).opacity(0.8)
                    }, header: {
                        Text("Place")
                    }, footer: {
                        Text("Give a more detailed description above.")
                    })
                    
                    Section("Tags") {
                        Picker("Tags", selection: $tagForItem, content: {
                            Text("No tag").tag(Optional<Tag>(nil))
                            ForEach(tags) { tag in
                                Text(tag.name).tag(tag as Tag?)
                            }
                            
                        }).padding(.trailing, 100)
                        Button("Add new tag") {
                            showAddTag = true
                        }
                    }
                    Section("Additional Informations") {
                        TextEditor(text:$remarks).frame(height: 100)
                    }
                    Section("Image") {
                        if let selectedPhotoData, let uiImage = UIImage(data: selectedPhotoData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: .infinity, maxHeight: 300)
                        } // shows the selected image if there is a valid one
                        PhotosPicker(selection: $selectedPhoto, matching: .images, photoLibrary: .shared()) {
                            Label("Add Image", systemImage: "photo")
                        }
                        if selectedPhotoData != nil {
                            Button(role:.destructive) {
                                withAnimation {
                                    selectedPhoto = nil
                                    selectedPhotoData = nil
                                }
                            } label: {
                                    Label("Remove Image", systemImage: "xmark")
                                        .foregroundStyle(.red)
                                }
                        }
                    }
                }
                .task(id: selectedPhoto) {
                    if let data = try? await selectedPhoto?.loadTransferable(type: Data.self) {
                        selectedPhotoData = data
                    }
                } //asynchronous loads the image from Photolibrary
                .navigationTitle("Add Item").navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading, content: {
                        Button("Cancel") {
                            dismiss()
                        }
                    })
                    ToolbarItem(placement: .topBarTrailing, content: {
                        Button("Save") {
                            if name != ""  {
                                let newItem = StuffedItem(name: name, place: placeForItem ?? nil)
                                newItem.detailedPlace = detailedPlaceDescription
                                newItem.remarks = remarks
                                newItem.image = selectedPhotoData ?? nil
                                newItem.tag = tagForItem ?? nil
                                context.insert(newItem)
                                id += 1
                                dismiss()
                            } else {
                                showNameAlert = true
                            }
                        }
                    })
                }
            }
            if showAddNewPlace {
                AddPlaceView()
            } // not as a sheet because this view already is a sheet
        }
        .sheet(isPresented: $showAddTag, content: {
            AddNewTagFromCheckList(showAddTag: $showAddTag, tagForChecklist: $tagForItem).presentationDetents([.small, .medium])
        })
    }
}

