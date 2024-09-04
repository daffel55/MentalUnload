//
//  EditTaskView.swift
//  MentalUnload
//
//  Created by Dagmar Feldt on 28.07.24.
//



import SwiftUI
import SwiftData

struct EditTaskView: View {
    var task : SnapTask
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    @Binding var id : Int
    @State var taskName = ""
    @State var numberOfDays : Int?
    @State var timePeriod : TimePeriod = .daysToDueDate
    @State var remarks = ""
    
    var body: some View {
        ZStack {
            NavigationStack {
                VStack {
                    Form {
                        Section(header: Text("Name of Task")) {
                            TextField("Enter Task Name", text : $taskName).textFieldStyle(.roundedBorder).font(.title)
                        }
                        Section("Time Interval"){
                            Picker("Choose days, weeks or months", selection: $timePeriod) {
                                Text("Days").tag(TimePeriod.daysToDueDate)
                                Text("Weeks").tag(TimePeriod.weeksToDueDate)
                                Text("Months").tag(TimePeriod.monthsToDueDate)
                            }.pickerStyle(.segmented)
                            TextField("\(textForNumberField()) until repeat", value: $numberOfDays, format: .number).keyboardType(.numberPad).font(.title).textFieldStyle(.roundedBorder)
                        }
                        //                    Section("Summary") {
                        //                        Text("Your Task: '\(taskName)' will be repeated every \(numberOfDays ?? 0) \(textForNumberField()).").font(.title2).foregroundStyle(.gray   )
                        //                    }
                        Section("Remarks") {
                            TextField("Remarks", text: $remarks, axis: .vertical).textFieldStyle(.roundedBorder).font(.title3)
                        }
                        
                        
                        
                    }.headerProminence(.increased)
                    

                }
                
                
                .padding()
                .navigationTitle("Edit Task")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading){
                        Button("Cancel") {
                            dismiss()
                        }.foregroundStyle(Color.blue)
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Save") {
                            if saveTask() {
                                id += 1
                                dismiss()
                            }
                        }.foregroundStyle(.blue)
                    }
                }
                
                
            }.onAppear {
                taskName = task.name
                numberOfDays = task.periodDays
                timePeriod = task.timePeriod
                remarks = task.remarks
            }
            
        }
        
        
    }
    
    func saveTask() -> Bool {
        guard taskName != "" && numberOfDays != nil else {return false}
        task.name = taskName
        task.periodDays = numberOfDays!
        task.timePeriod = timePeriod
        task.remarks = remarks
        task.setDueDate()
        return true
        
    }
    
    func textForNumberField() -> String {
        switch timePeriod {
        case .daysToDueDate:
            return "days"
        case .monthsToDueDate:
            return "months"
        case .weeksToDueDate:
            return "weeks"
        }
    }
}

#Preview {
    AddTaskView()
}

