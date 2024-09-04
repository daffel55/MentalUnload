//
//  EditMemoryView.swift
//  MentalUnload
//
//  Created by Dagmar Feldt on 28.07.24.
//


import SwiftUI
import PhotosUI
import SwiftData

struct EditMemoryView: View {
    @Bindable var memory : Memory // every change on that value should refresh parent view
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    @Query var tags : [Tag]
    // properties to hold the values of the Memory
    @State var date = Date.now
    @State var title = ""
    @State var descriptionText = ""
    @State var conclusion = ""
    @State var newTask = ""
    @State var unfinishedTasks = [UnfinishedTask]()
    @State var furtherNotice = false
    @State var showRemoveAlert = false
    @State var selectedPhoto : PhotosPickerItem?
    @State var selectedPhotoData : Data?
    @State var tagForMemory : Tag?
    @State var showAddTag = false
    
    // I couldnt figure out how to come from DetailView which is a sheet itself to this view without tampering the navigation toolbar, so I made it with these conditionals
    @Binding var linkFromDetail : Bool
    @Binding var showEditView : Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                Form {
                    Section(content: {
                        DatePicker("Start date", selection: $date, displayedComponents: .date).datePickerStyle(.compact)
                    }, header: {
                        Text("Date")
                    }, footer: {
                        Text("If you want to specify a timeperiod, do so in description")
                    })
                    Section(content: {
                        TextField("", text: $title).textFieldStyle(.roundedBorder)
                    }, header: {
                        Text("Title")
                    }, footer: {
                        Text("A memory can't be saved without a title.")
                    })
                    Section("Tags") {
                        Picker("Tags", selection: $tagForMemory, content: {
                            Text("No tag").tag(Optional<Tag>(nil))
                            ForEach(tags) { tag in
                                Text(tag.name).tag(tag as Tag?)
                            }
                            
                        }).padding(.trailing, 100)
                        Button("Add new tag") {
                            showAddTag = true
                        }
                    }
                    Section(content: {
                        TextEditor(text: $descriptionText)
                            .textFieldStyle(.roundedBorder)
                            .frame(height: 80)
                    }, header: {
                        Text("Description")
                    }, footer: {
                        Text("Describe in more details.")
                    })
                    Section(content: {
                        TextEditor(text: $conclusion)
                            .textFieldStyle(.roundedBorder)
                            .frame(height: 80)
                    }, header: {
                        Text("Conclusion")
                    }, footer: {
                        Text("What will be important for another situation like this?")
                    })
                    Section(content: {
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
                    }, header: {
                        Text("Image")
                    }, footer: {
                        Text("Only one image can be stored")
                    })
                   Section(content: {
                       Toggle(isOn: $furtherNotice, label: {
                           Text("Unfinished Tasks?")})
                       if furtherNotice {
                           ForEach(0..<unfinishedTasks.count, id: \.self) { count in
                               
                               if unfinishedTasks.count != 0 {
                                   HStack{
                                       TextField(unfinishedTasks[count].name,text: $unfinishedTasks[count].name)
                                       if unfinishedTasks.count >= 1 {
                                           Button(action: {
                                               if unfinishedTasks.count > 1 {
                                                   unfinishedTasks.remove(at: count)
                                               }
                                               if unfinishedTasks.count == 1 {
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
                               TextField("",text: $newTask)
                               Button(action: {
                                   if !newTask.isEmpty {
                                       unfinishedTasks.append(UnfinishedTask(name: newTask))
                                       newTask = ""
                                   }
                               }, label: {
                                   Image(systemName: "plus")
                               })
                               
                               
                               
                           }
                       }
                   }, header: {
                       Text("Tasks")
                   }, footer: {
                       Text("Are there tasks related to this memory?")
                   })
                    
                }
                }
                .navigationTitle("Edit Memory")
                .toolbar {
//                    ToolbarItem(placement: .topBarLeading, content: {
//                        Button("Cancel") {
//                            if linkFromDetail {
//                               showEditView = false
//                            } else {
//                                dismiss()
//                            }
//                        }
//                    })
                    ToolbarItem {
                        if title == "" {
                            Text("You can't save without a title").foregroundStyle(.gray)
                        }
                    }
                    ToolbarItem(placement: .topBarTrailing, content: {
                        if title != "" {
                            Button("Save") {
                                if newTask != "" {
                                    unfinishedTasks.append(UnfinishedTask(name: newTask))
                                }
                                
                                memory.title = title
                                memory.date = date
                                memory.descriptionText = descriptionText
                                memory.conclusion = conclusion
                                memory.furtherNotice = furtherNotice
                                memory.unfinishedTasks = unfinishedTasks
                                memory.image = selectedPhotoData
                                
                                dismiss()
                            }
                        }
                        })
                    
                }
                .onAppear {
                    date = memory.date
                    title = memory.title
                    descriptionText = memory.descriptionText
                    conclusion = memory.conclusion
                    tagForMemory = memory.tag
                    if memory.image != nil {
                        selectedPhotoData = memory.image
                    }
                    if furtherNotice {
                        unfinishedTasks = memory.unfinishedTasks
                    } else {
                        memory.unfinishedTasks = []
                    }
                    furtherNotice = memory.furtherNotice
                }
                .task(id: selectedPhoto) {
                    if let data = try? await selectedPhoto?.loadTransferable(type: Data.self) {
                        selectedPhotoData = data
                    }
                }
                .alert(NSLocalizedString("notAllEntries", comment: ""), isPresented: $showRemoveAlert, actions: {
                    Button("Okay", role: .cancel) {
                        
                    }
                })
            }
        }
    
}


