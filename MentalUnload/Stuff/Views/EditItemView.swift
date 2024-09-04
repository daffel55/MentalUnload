//
//  EditItemView.swift
//  MentalUnload
//
//  Created by Dagmar Feldt on 27.07.24.
//  Refactored and commented 09.08.24



import SwiftUI
import SwiftData
import PhotosUI

struct EditItemView: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    
    var item : StuffedItem //the item to update
    @Query var places : [Place] // read all places
    // the following properties take all properties of a stuffitem, they will be filled with the item-in-question's properites with task, then they will all be rewritten with save. If the user changes one or more of them they will be updated in that way.
    @Query var tags : [Tag]
    @State private var name = ""
    @State var placeForItem: Place?
    @State private var detailedPlaceDescription : String = ""
    @State private var remarks : String = ""
    @State var selectedPhoto : PhotosPickerItem?
    @State var selectedPhotoData : Data?
    @State var tagForItem : Tag?
    @State var showAddTag = false
    @State var showNoNameAlert = false // user must enter a name
    
    // If user adds a new place from EditItemView this place should be populated to the picker and there should be no need to enter it from the picker's list again. To achieve this I made AddPlacesFromEditItem, which then gets these properties as Bindings, and if newPlaceAdded changes /that means if user hit save at AddPlaceCiew) the placeForItem gets this new place
    @State var placeFromAddPlace : Place?
    @State private var showAddNewPlace = false
    @State private var newPlaceAdded = false
    
    var body: some View {
        ZStack {
            NavigationStack {
                Form {
                    Section("What did you stowed away?") {
                        TextField(showNoNameAlert ? "This field can't be empty" : "\(name)", text: $name).textFieldStyle(.roundedBorder)
                            .border(showNoNameAlert ? Color.red : Color.clear).font(.title)
                    }
                    Section("Where did you store that stuff?") {
                                Picker("Place", selection: $placeForItem, content: {
                                    Text("noFold").tag(Optional<Place>(nil))
                                    ForEach(places) { place in
                                        Text(place.name).tag(place as Place?)
                                    }
                                })
                        HStack {
                            Text("Or add a new place:")
                            Spacer()
                            Button("Add Place") {
                                showAddNewPlace = true
                            }
                        }.padding(.trailing, 10)
                    
                        TextEditor(text: $detailedPlaceDescription)
                            .multilineTextAlignment(.leading)
                            .frame(height: 100)
                       
                    }
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
                    Section("Any Remarks?") {
                        TextEditor(text:$remarks)
                            .multilineTextAlignment(.leading)
                            .frame(height: 100)
                        
                    }
                    Section("Image") {
                        if let selectedPhotoData, let uiImage = UIImage(data: selectedPhotoData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: .infinity, maxHeight: 300)
                        }
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
                }
                .navigationTitle("Edit Item").navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading, content: {
                        Button("Cancel") {
                            dismiss()
                        }
                    })
                    ToolbarItem(placement: .topBarTrailing, content: {
                        Button("Save") {
                            if name != "" {
                                item.name = name
                                item.place = placeForItem
                                item.detailedPlace = detailedPlaceDescription
                                item.remarks = remarks
                                item.image = selectedPhotoData
                                item.tag = tagForItem
                                dismiss()
                            } else {
                                showNoNameAlert = true
                            }
                        }
                    })
                }
            }
            if showAddNewPlace {
                AddPlaceFromEditItem(place: $placeFromAddPlace, newPlaceAdded: $newPlaceAdded, showAddPlace: $showAddNewPlace)
            }
        }
        .onChange(of: newPlaceAdded, {
            
            self.placeForItem = placeFromAddPlace //placeFromAddPlace is set y AddPlaceView when user saves
        })
        .sheet(isPresented: $showAddTag, content: {
            AddNewTagFromCheckList(showAddTag: $showAddTag, tagForChecklist: $tagForItem).presentationDetents([.small, .medium])
        })
        .task { // populates all properties into the temporary properties of this view
            self.name = item.name
            if item.place != nil {
                self.placeForItem = item.place!
            }
            self.detailedPlaceDescription = item.detailedPlace
            self.remarks = item.remarks
            self.tagForItem = item.tag
            if item.image != nil {
                selectedPhotoData = item.image
            }
            
        }
    }
}


