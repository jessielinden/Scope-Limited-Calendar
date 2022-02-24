//
//  CalendarView.swift
//  Scope-Limited Calendar
//
//  Created by Jessica Linden on 2/18/22.
//

import SwiftUI

struct WeekView<DateView>: View where DateView: View {
  @Environment(\.calendar) var calendar
  
  let week: Date
  let content: (Date) -> DateView
  
  init(week: Date, @ViewBuilder content: @escaping (Date) -> DateView) {
    self.week = week
    self.content = content
  }
  
  private var days: [Date] {
    guard
      let weekInterval = calendar.dateInterval(of: .weekOfYear, for: week)
    else { return [] }
    return calendar.generateDates(
      inside: weekInterval,
      matching: DateComponents(hour: 0, minute: 0, second: 0)
    )
  }
  
  var body: some View {
    HStack {
      ForEach(days, id: \.self) { date in
        HStack {
          if self.calendar.isDate(self.week, equalTo: date, toGranularity: .month) {
            self.content(date)
          } else {
            self.content(date).hidden()
          }
        }
      }
    }
  }
}

struct MonthView<DateView>: View where DateView: View {
  @Environment(\.calendar) var calendar
  @EnvironmentObject var calendarManager: CalendarManager
  
  @State private var month: Date
  let showHeader: Bool
  let content: (Date) -> DateView
  
  var isFirstMonth: Bool {
    if getComparableMonthDate() == calendarManager.firstMonth {
      return true
    } else {
      return false
    }
  }
  
  var isLastMonth: Bool {
    if getComparableMonthDate() == calendarManager.lastMonth {
      return true
    } else {
      return false
    }
  }
  
  init(
    month: Date,
    showHeader: Bool = true,
    localizedWeekdays: [String] = [],
    @ViewBuilder content: @escaping (Date) -> DateView
  ) {
    self._month = State(initialValue: month)
    self.content = content
    self.showHeader = showHeader
  }
  
  private var weeks: [Date] {
    guard
      let monthInterval = calendar.dateInterval(of: .month, for: month)
    else { return [] }
    return calendar.generateDates(
      inside: monthInterval,
      matching: DateComponents(hour: 0, minute: 0, second: 0, weekday: calendar.firstWeekday)
    )
  }
  
  func changeDateBy(_ months: Int) {
    if let date = Calendar.current.date(byAdding: .month, value: months, to: month) {
      self.month = date
    }
  }
  
  func getComparableMonthDate() -> DateComponents {
    let dateMonthYear = calendar.dateComponents([.month, .year], from: month)
    return dateMonthYear
  }
  
  private var header: some View {
    let component = calendar.component(.month, from: month)
    let formatter = component == 1 ? DateFormatter.monthAndYear : .month
    return HStack {
      Text(formatter.string(from: month))
        .font(.title)
        .padding(.horizontal)
      Spacer()
      HStack {
        Group {
          Button(action: {
            self.changeDateBy(-1)
          }) {
            Image(systemName: "chevron.left.square")
              .resizable()
          }
          .opacity(isFirstMonth ? 0 : 1)
          .disabled(isFirstMonth)
          
          Button(action: {
            self.month = Date()
          }) {
            Image(systemName: "dot.square")
              .resizable()
          }
          Button(action: {
            self.changeDateBy(1)
          }) {
            Image(systemName: "chevron.right.square")
              .resizable()
          }
          .opacity(isLastMonth ? 0 : 1)
          .disabled(isLastMonth)
          
        }
        .foregroundColor(Color.blue)
        .frame(width: 25, height: 25)
        
      }
      .padding(.trailing, 20)
    }
    
  }
  
  var body: some View {
    VStack {
      if showHeader {
        header
      }
      HStack {
        ForEach(0..<7, id: \.self) { index in
          Text("30")
            .padding(20)
            .foregroundColor(Color.black)
            .hidden()
            .overlay(
              Text(getWeekDaysSorted()[index].uppercased()))
        }
      }
      
      ForEach(weeks, id: \.self) { week in
        WeekView(week: week, content: self.content)
      }
      Spacer()
    }
    .frame(width: 500)
  }
  
  func getWeekDaysSorted() -> [String] {
    let weekDays = Calendar.current.shortWeekdaySymbols
    let sortedWeekDays = Array(weekDays[Calendar.current.firstWeekday - 1 ..< Calendar.current.shortWeekdaySymbols.count] + weekDays[0 ..< Calendar.current.firstWeekday - 1])
    return sortedWeekDays
  }
}

struct CalendarView<DateView>: View where DateView: View {
  @Environment(\.calendar) var calendar
  
  let interval: DateInterval
  let content: (Date) -> DateView
  
  init(interval: DateInterval, @ViewBuilder content: @escaping (Date) -> DateView) {
    self.interval = interval
    self.content = content
  }
  
  private var months: [Date] {
    calendar.generateDates(
      inside: interval,
      matching: DateComponents(day: 1, hour: 0, minute: 0, second: 0)
    )
  }
  
  var body: some View {
    ForEach(months, id: \.self) { month in
      MonthView(month: month, content: self.content)
    }
  }
}


