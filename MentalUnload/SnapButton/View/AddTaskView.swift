//
//  AddTaskView.swift
//  MentalUnload
//
//  Created by Dagmar Feldt on 28.07.24.
//



import SwiftUI
import SwiftData

struct AddTaskView: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) var dismiss
    @State var taskName = ""
    @State var numberOfDays : Int?
    @State var timePeriod : TimePeriod = .daysToDueDate
    @State var remarks = ""
    
    var body: some View {
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

                    Section("Remarks") {
                        TextField("Remarks", text: $remarks, axis: .vertical).textFieldStyle(.roundedBorder).font(.title3)
                    }
                    
                    
                }.headerProminence(.increased)
            }
            .padding()
            .navigationTitle("New Task")
            .toolbar {
                ToolbarItem(placement: .topBarLeading, content: {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                })
                ToolbarItem(placement: .topBarTrailing, content: {
                    Button("Save") {
                        if taskName != "" && numberOfDays != nil {
                            saveTask()
                            dismiss()
                        }
                        
                    }
                })
            }
            
            
        }
        
    }
    
    func saveTask() {
        guard taskName != "" && numberOfDays != nil else {return}
        let newTask = SnapTask(name: taskName, timePeriod: timePeriod, numberOfDaysOrMonths: numberOfDays ?? 0)
        if remarks != "" {
            newTask.remarks = remarks
            
        }
        context.insert(newTask)
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


