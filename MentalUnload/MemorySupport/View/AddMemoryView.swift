//
//  AddMemoryView.swift
//  MentalUnload
//
//  Created by Dagmar Feldt on 28.07.24.
//



import SwiftUI
import PhotosUI
import SwiftData

struct AddMemoryView: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    @Query var tags : [Tag]
    @State var title = ""
    @State var descriptionText = ""
    @State var conclusion = ""
    @State var date = Date.now
    @State var furtherNotice : Bool = false
    @State var unfinishedTasks = [UnfinishedTask]()
    @State var itemPlaceHolder = "Enter a task and press + for more"
    @State var newTask : String = ""
    @State var selectedPhoto : PhotosPickerItem?
    @State var selectedPhotoData : Data?
    @State var id = 0
    @State var tagForMemory : Tag?
    @State var showAddTag = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Form {
                    Section(content: {
                        DatePicker("Select a start date", selection: $date, displayedComponents: .date).datePickerStyle(.compact)
                    }, header: {
                        Text("Date")
                    }, footer: {
                        Text("If you want to specify a timeperiod, do so in description").foregroundStyle(.gray).font(.caption)
                    })
                    Section(content: {
                        TextField("What do you want to remember.", text: $title).textFieldStyle(.roundedBorder)
                    }, header: {
                        Text("Add Title")
                    }, footer: {
                        Text("You can't save without a title")
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
                    }, header: {
                        Text("Description")
                    }, footer: {
                        Text("Give a more detailed describtion here.")
                    })
                    
                    Section(content: {
                        TextEditor(text: $conclusion)
                            .textFieldStyle(.roundedBorder)
                    }, header: {
                        Text("Conclusion")
                    }, footer: {
                        Text("What could be relevant for you or for the same situation or something like this?")
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
                        Text("Only one image can be stored with a memory")
                    })
                    
                    Section(content: {
                        Toggle("Unfinished Tasks", isOn: $furtherNotice)
                        if furtherNotice {
                            ForEach(0..<unfinishedTasks.count, id: \.self) { count in
                                
                                if unfinishedTasks.count != 0 {
                                    HStack{
                                        TextField(unfinishedTasks.count == 0 ? "Enter task " : unfinishedTasks[count].name,text: $unfinishedTasks[count].name)
                                        if unfinishedTasks.count >= 1 {
                                            Button(action: {
                                                if unfinishedTasks.count > 1 {
                                                    unfinishedTasks.remove(at: count)
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
                        Text("Are there unfinished tasks related to this memo?")
                    })
                   
                }
            }
            .navigationTitle("Add Memory")
            .toolbar {
                ToolbarItem(placement: .topBarLeading, content: {
                    Button("Cancel") {
                        dismiss()
                    }
                })
                
                ToolbarItem(placement: .topBarTrailing, content: {
                    
                    Button("Save") {
                        if newTask != "" {
                            unfinishedTasks.append(UnfinishedTask(name: newTask))
                        }
                        let newMemory = Memory(title: title, descriptionText: descriptionText, conclusion: conclusion)
                        newMemory.date = date
                        newMemory.furtherNotice = furtherNotice
                        newMemory.unfinishedTasks = unfinishedTasks
                        newMemory.image = selectedPhotoData
                        newMemory.tag = tagForMemory ?? nil
                        context.insert(newMemory)
                        dismiss()
                    }.disabled(title == "")
                
                })
            }
            
            .task(id: selectedPhoto) {
                if let data = try? await selectedPhoto?.loadTransferable(type: Data.self) {
                    selectedPhotoData = data
                }
            }
        }
    }
    func giveHeaderText() -> String {
        title == "" ? "Add Title...you can't save without it" : "Add Title"
    }
    
    
}

#Preview {
    AddMemoryView()
}

