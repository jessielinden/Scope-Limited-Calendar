//
//  ContentView.swift
//  Scope-Limited Calendar
//
//  Created by Jessica Linden on 2/18/22.
//

import SwiftUI

struct ContentView: View {
  
  @Environment(\.calendar) var calendar
  private var year: DateInterval {
    calendar.dateInterval(of: .month, for: Date())!
  }
  
  var body: some View {
    ScrollView(showsIndicators: false) {
      CalendarView(interval: self.year) { date in
        Text("30")
          .padding(20)
          .foregroundColor(Color.black)
          .hidden()
          .background(Color.white)
          .cornerRadius(5)
          .overlay(
            Text(String(self.calendar.component(.day, from: date)))
              .foregroundColor(isTodaysDate(date) ? .red : .blue)
          )
      }
      .padding(.vertical)
      .frame(height: 550)
    }
  }
  
  func isTodaysDate(_ calDate: Date) -> Bool {
    let day = Calendar.current.dateComponents([.day, .month, .year], from: Date())
    
    let calDay = Calendar.current.dateComponents([.day, .month, .year], from: calDate)
    
    if day == calDay {
      return true
    } else {
      return false
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    if #available(iOS 15.0, *) {
      GeometryReader { geo in
        ZStack {
          Color.gray.opacity(0.2)
            .edgesIgnoringSafeArea(.all)
          ContentView()
            .environmentObject(CalendarManager())
        }
      }
      .previewInterfaceOrientation(.landscapeLeft)
    } else {
      // Fallback on earlier versions
    }
  }
}
