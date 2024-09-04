//
//  CalendarCalculations.swift
//  MentalUnload
//
//  Created by Dagmar Feldt on 28.07.24.
//
import Foundation

func someDaysfromNow(_ days : Int) -> Date {
   return (Calendar.current as NSCalendar).date(byAdding: .day, value: days, to: Date(), options: [])!
}
func someMonthsFromNow(_ months: Int) -> Date {
    return (Calendar.current as NSCalendar).date(byAdding: .month, value: months, to: Date(), options: [])!
}
func someWeeksFromNow(_ weeks: Int) -> Date {
    return (Calendar.current as NSCalendar).date(byAdding: .day, value: weeks * 7, to: Date(), options: [])!
}

extension Date {
    public func setTime(hour: Int, timeZoneAbbrev: String = "UTC") -> Date? {
        let x: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let cal = Calendar.current
        var components = cal.dateComponents(x, from: self)

        components.timeZone = TimeZone(abbreviation: timeZoneAbbrev)
        components.hour = hour
        components.minute = 0
        components.second = 0

        return cal.date(from: components)
    }
}
