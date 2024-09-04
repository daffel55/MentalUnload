//
//  HelperSnapButton.swift
//  MentalUnload
//
//  Created by Dagmar Feldt on 28.07.24.
//

//
//  HelperViews.swift
//  SnapButton
//
//  Created by Dagmar Feldt on 17.07.24.
//

import SwiftUI

struct RedButton : View {
    @Environment(\.modelContext) var context
    @State var showInfo = false
    @State var showEdit = false
    var task : SnapTask
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(setColor(snapTask: task).gradient.shadow(.drop(color: .black, radius: 5, x: 2, y: 3)))
                .frame(width: 346, height: 130)
            HStack {
                Spacer()
                VStack(spacing: 3) {
                    Text(task.name)
                        .font(.title2)
                        .foregroundStyle(.white)
                        .padding(.bottom,0)
                    Text("overdue!")
                        .padding(.horizontal)
                        .foregroundStyle(.black)
                    Text("Since \(task.dueDate!, style: .date)")
                        .font(.caption).padding(.horizontal).foregroundStyle(.black)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Spacer()
                    infoButton(snapTask: task)
                    
                    Spacer()
                    trashButton(snapTask: task)
                    Spacer()
                }.padding(.trailing, 7)
            }.sheet(isPresented: $showInfo, content: {
                VStack(content: {
                    Text(task.name).font(.title)
                    Text(infoText(snapTask: task))
                    if task.remarks != "" {
                        Text("").font(.title2).padding(.bottom,0)
                        Text(task.remarks).multilineTextAlignment(.leading).padding(.top, 0)
                            .padding(.horizontal)
                    }
                }).presentationDetents([.height(200), .fraction(20), .medium, .large])
            })
            
        }
    }
    
    func setTaskActive(task: SnapTask) {
        task.isActive = true
        task.isOverdue = false
        task.creationDate = Date.now.setTime(hour: 9)!
        task.setDueDate()
    }
    
    func infoText(snapTask: SnapTask) -> String {
        var str = ""
        let count = snapTask.periodDays
        switch snapTask.timePeriod {
        case .daysToDueDate:
            str = " days"
        case .monthsToDueDate:
            str = " months"
        case .weeksToDueDate:
            str = " weeks"
        }
        return "Will be repeated every \(count) \(str)"
    }
    func trashButton(snapTask: SnapTask) -> some View {
        Image(systemName: "trash")
            .foregroundStyle(snapTask.isActive ? .brightMint : .black)
            //.offset(x: 150, y: 25)
            .onTapGesture {
                context.delete(snapTask)
            }
    }
    
    func infoButton(snapTask: SnapTask) -> some View {
        Image(systemName: "info.circle")
            .foregroundColor(snapTask.isActive ? .brightMint : .black)
            .onTapGesture {
                withAnimation {
                    showInfo = true
                }
            }
    }
    
}

struct TaskButton: View {
    @Environment(\.modelContext) var context
    @Binding var id: Int
    var snapTask : SnapTask
    @State var showInfo = false
    @State var showEdit = false
    var body: some View {
        ZStack {
            if snapTask.isActive {
                RoundedRectangle(cornerRadius: 10).fill(setColor(snapTask: snapTask).gradient.shadow(.inner(color: .black, radius: 4, x: 2, y: 2)))
                    .frame(width: 350, height: 130)
            } else {
                RoundedRectangle(cornerRadius: 10)
                    .fill(setColor(snapTask: snapTask).gradient.shadow(.drop(color: .black, radius: 5, x: 2, y: 3)))
                    .frame(width: 346, height: 130)
            }
            HStack {
                Spacer()
                VStack {
                    Text(snapTask.name)
                        .padding(.bottom,0)
                        .font(.title2)
                        .foregroundStyle(snapTask.isActive ? .white : .background)
                    if snapTask.isActive{
                        Text("End date: \(snapTask.dueDate!.formatted(date: .abbreviated, time: .omitted))")
                            .foregroundStyle(snapTask.isActive ? .orange : .clear)
                    } else {
                        Text("Not started yet")
                    }
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Spacer()
                    infoButton(snapTask: snapTask)
                    Spacer()
                    stopButton(snapTask: snapTask)
                    Spacer()
                    trashButton(snapTask: snapTask)
                    Spacer()
                }.padding(.trailing, 7)
            }
            
            
        }.fixedSize(horizontal: false, vertical: true)
            .sheet(isPresented: $showInfo, content: {
                VStack(content: {
                    Text(snapTask.name).font(.title)
                    Text(infoText(task: snapTask)).font(.title3)
                    if snapTask.remarks != "" {
                        Text("").font(.title2).padding(.bottom,0)
                        Text(snapTask.remarks).multilineTextAlignment(.leading).padding(.top, 0)
                            .padding(.horizontal)
                    }
                    
                    
                }).presentationDetents([.height(200), .fraction(20), .medium, .large])
            })
            .onTapGesture {
                if !snapTask.isActive {
                    setTaskActive(task: snapTask)
                }
                else {
                    
                    showEdit = true
                }
            }

            .sheet(isPresented: $showEdit, content: {
                EditTaskView(task: snapTask, id: $id)
            })
            
            
    }
    
    func setTaskActive(task: SnapTask) {
        task.isActive = true
        task.isOverdue = false
        task.creationDate = Date.now.setTime(hour: 9)!
        task.setDueDate()
    }
    
    func trashButton(snapTask: SnapTask) -> some View {
        Image(systemName: "trash")
            .foregroundStyle(snapTask.isActive ? .brightMint : .black)
            //.offset(x: 150, y: 25)
            .onTapGesture {
                context.delete(snapTask)
            }
    }
    func stopButton(snapTask: SnapTask) -> some View {
        Image(systemName: "stop.circle")
            .foregroundStyle(snapTask.isActive ? .brightMint : .clear)
            //.offset(x: -140, y: 25)
            .onTapGesture {
                snapTask.isActive = false
            }
    }
    func infoButton(snapTask: SnapTask) -> some View {
        Image(systemName: "info.circle")
            .foregroundColor(snapTask.isActive ? .brightMint : .black)
            .onTapGesture {
                withAnimation {
                    showInfo = true
                }
            }
    }
    
    func infoText(task: SnapTask) -> String {
        var str = ""
        let count = task.periodDays
        switch task.timePeriod {
        case .daysToDueDate:
            str = " days"
        case .monthsToDueDate:
            str = " months"
        case .weeksToDueDate:
            str = " weeks"
        }
        return "Will be repeated every \(count) \(str)"
    }
    
}



