//
//  ContentViewSnapButton.swift
//  MentalUnload
//
//  Created by Dagmar Feldt on 28.07.24.
//

//
//  ContentView.swift
//  SnapButton
//
//  Created by Dagmar Feldt on 13.07.24.
//

import SwiftUI
import SwiftData
import UserNotifications

struct ContentViewSnapButton: View {
    @AppStorage("showInfoSnapButton") var showInfoSnapButton = true
    @Environment(\.modelContext) var context
    @Query(sort: \SnapTask.dueDate, order: .forward) var snapTasks : [SnapTask]
    @State var active = false
    @State private var baseColor: Color = .mint//.init(red: 232/255, green: 232/255, blue: 232/255)
    @State var overdue = false
    @State var newTask = false
    private let shadowColor: Color = .black.opacity(0.7)//.init(red: 197/255, green: 197/255, blue: 197/255)
    @State private var daysWaiting : Float = 432000
    @State private var badgeNumber = 0
    @State private var showEdit = false
    @State private var showEditFromOverDue = false
    
    @State var taskToEdit : SnapTask?
    @State var badgeManager = AppAlertBadgeManager(application: UIApplication.shared)
    @State var id = 0
    var daysUntiReady : Float {
        daysWaiting / 60 / 60 / 25
    }
    let timer = Timer.publish(every: 300, on: .main, in: .common).autoconnect() // 2 Stunde = 3600
    
    var overdueTasks : [SnapTask] {
        snapTasks.filter {
            $0.isOverdue
        }
    }
    var dueTasks : [SnapTask] {
        snapTasks.filter {
            !$0.isOverdue
        }
    }
    //sort{ ($0.date ?? .distantPast) > ($1.date ?? .distantPast) }
    let center = UNUserNotificationCenter.current()
    
    var body: some View {
        ZStack {
            NavigationStack {
                ScrollView {
                    VStack {
 
                        VStack(alignment: .center, spacing: 50) {
                            ForEach(overdueTasks) { snapTask in
                                    RedButton(task: snapTask)
                                        .frame(width: 350, height: 100)
                                        .onTapGesture {
                                            if badgeNumber != 0 {
                                                badgeNumber -= 1
                                            }
                                            badgeManager.setAlertBadge(number: badgeNumber)
                                            withAnimation {
                                                setTaskActive(snapTask: snapTask)
                                            }
                                        }
                                        .onLongPressGesture(perform: {
                                           
                                            showEditFromOverDue = true
                                        })
                                        
                                    
                                
                            }
                            ForEach(dueTasks) { snapTask in
                                TaskButton(id: $id, snapTask: snapTask).frame(width: 350, height: 100)
                                    .onTapGesture {
                                        if !snapTask.isActive {
                                            withAnimation {
                                                setTaskActive(snapTask: snapTask)
                                            }
                                        }
                                        else {
                                            taskToEdit = snapTask
                                            showEdit = true
                                        }
                                    }

                                    
                            }
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 2) {
                            
                            if showInfoSnapButton {
                                Group {
                                    Text("1. To add task, tap the plus button at the upper right of the screen")
                                    Text("2. To start a task, simply press the button with its name on it")
                                    Text("3. To edit a task, tap on the started task.")
                                    Text("4. To stop a task before it is due, tap the stop button on a started task.")
                                    Text("5. To get details about a task, tap the info button")
                                    Text("6. To delete a task tap the trash button.")
                                }
                            }
                            Toggle(isOn: $showInfoSnapButton) {
                                Text(showInfoSnapButton ? "Hide Info" : "ShowInfo")
                            }.padding(.horizontal, 80)
                        }.foregroundStyle(.gray).font(.body).padding().padding(.top, 40)
                        
                    }
                    .navigationTitle("Automate Tasks")
                    .frame(maxWidth: .infinity)
                    .padding(.top, 40)
                    .toolbar(content: {

                        ToolbarItem(placement:.topBarTrailing ,content: {
                            Button {
                                newTask = true
                            } label: {
                                Label("New Task", systemImage: "plus")
                            }
                        })
                    }).tint(.blue)
                    
                }
                .sheet(isPresented: $showEditFromOverDue, content: {
                    
                    EditTaskView(task: taskToEdit!, id: $id)
                })
                .sheet(isPresented: $newTask, content: {
                    AddTaskView()
                })
                .frame(maxWidth: .infinity)
                .background(Color.lightGrey)
            }
            
        }
        
        
        
        .task {
            var number = 0
            for snapTask in snapTasks {
                if snapTask.taskIsDue() {
                    snapTask.isOverdue = true
                    snapTask.isActive = false
                    number += 1
                }
            }
            badgeNumber = number
            do {
                try await center.setBadgeCount(badgeNumber)
            } catch {
                print(error.localizedDescription)
            }
        }
        .onReceive(timer, perform: { _ in
            var number = 0
            for snapTask in snapTasks {
                if snapTask.taskIsDue() {
                    snapTask.isOverdue = true
                    snapTask.isActive = true
                    number += 1
                    NotificationManager.sendNotification(snapTask: snapTask)
                }
            }
            badgeNumber = number
            center.setBadgeCount(badgeNumber)
        })
    }
    
    
    func setTaskActive(snapTask: SnapTask) {
        snapTask.isActive = true
        snapTask.isOverdue = false
        snapTask.creationDate = Date.now.setTime(hour: 9)!
        snapTask.setDueDate()
    }
}

func setColor(snapTask : SnapTask) -> Color {
    if snapTask.isOverdue {
        return Color.red
    } else if snapTask.isActive {
        return Color.activeTask
    }
    return Color.brightMint
}



