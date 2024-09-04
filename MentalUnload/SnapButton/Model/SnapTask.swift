//
//  SnapTask.swift
//  MentalUnload
//
//  Created by Dagmar Feldt on 28.07.24.
//


import Foundation
import SwiftData


@Model
class SnapTask {
    var name = ""
    var creationDate : Date = Date.now.setTime(hour: 9)!
    var isActive = false
    var isOverdue = false
    var dueDate : Date?
    var periodDays = 0
    var timePeriod : TimePeriod = TimePeriod.daysToDueDate
    var remarks = ""
    init(name: String, timePeriod: TimePeriod, numberOfDaysOrMonths: Int) {
        self.name = name
        self.timePeriod = timePeriod
        self.periodDays = numberOfDaysOrMonths
    }
}

extension SnapTask {
   
    func taskIsDue() -> Bool {
        if self.dueDate != nil {
            if self.dueDate!.setTime(hour: 9)! <= Date.now.setTime(hour: 9)! {
                self.isOverdue = true
                return true
            }
        }
        self.isOverdue = false
        return false
    }
    
    func setDueDate() {
        switch self.timePeriod {
        case .daysToDueDate:
            self.dueDate = (Calendar.current as NSCalendar).date(byAdding: .day, value: periodDays, to: creationDate, options: [])!
        case .weeksToDueDate :
            self.dueDate = (Calendar.current as NSCalendar).date(byAdding: .day, value: periodDays * 7, to: creationDate, options: [])!
            
        case .monthsToDueDate:
            self.dueDate = (Calendar.current as NSCalendar).date(byAdding: .month, value: periodDays, to: creationDate, options: [])!
        }
        
    }
}

extension Bool: Comparable {
    public static func <(lhs: Self, rhs: Self) -> Bool {
        // the only true inequality is false < true
        lhs && rhs
    }
}

enum TimePeriod : Int, Codable {
    case daysToDueDate = 1
    case monthsToDueDate = 2
    case weeksToDueDate = 3
}


