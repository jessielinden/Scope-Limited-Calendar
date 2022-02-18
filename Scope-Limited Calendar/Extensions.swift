//
//  Extensions.swift
//  Scope-Limited Calendar
//
//  Created by Jessica Linden on 2/18/22.
//

import Foundation

extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }
    
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}

 extension DateFormatter {
  static var month: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMMM"
    return formatter
  }
  
  static var monthAndYear: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMMM yyyy"
    return formatter
  }
}

extension Calendar {
  func generateDates(
    inside interval: DateInterval,
    matching components: DateComponents
  ) -> [Date] {
    var dates: [Date] = []
    dates.append(interval.start)
    
    enumerateDates(
      startingAfter: interval.start,
      matching: components,
      matchingPolicy: .nextTime
    ) { date, _, stop in
      if let date = date {
        if date < interval.end {
          dates.append(date)
        } else {
          stop = true
        }
      }
    }
    
    return dates
  }
}
