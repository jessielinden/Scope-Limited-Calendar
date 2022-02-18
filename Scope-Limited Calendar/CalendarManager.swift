//
//  CalendarManager.swift
//  Scope-Limited Calendar
//
//  Created by Jessica Linden on 2/18/22.
//

import Foundation

class CalendarManager: ObservableObject {
  
  // some sample dates to work with
  let startDate: Date = Date()
  let endDate: Date = Date().addingTimeInterval(86400 * 200)
  let interval: DateInterval
  var comparableMonthYearPairs: [DateComponents] = []
  
  var firstMonth: DateComponents {
    comparableMonthYearPairs.first!
  }
  
  var lastMonth: DateComponents {
    comparableMonthYearPairs.last!
  }
  
  init() {
    self.interval = DateInterval(start: startDate, end: endDate)
    getMonthYearArray()
  }
  
  func getMonthYearArray() {
    let myInterval = DateInterval(start: startDate, end: endDate)
    let dates = Calendar.current.generateDates(inside: myInterval, matching: DateComponents(hour: 0, minute: 0, second: 0))
    var dateComponents: [DateComponents] = []
    for i in 0..<dates.count {
      let monthYear = Calendar.current.dateComponents([.month, .year], from: dates[i])
      if !dateComponents.contains(where: { $0 == monthYear }) {
        dateComponents.append(monthYear)
      }
    }
    comparableMonthYearPairs = dateComponents
    print(dateComponents)
  }
}
