//
//  Scope_Limited_CalendarApp.swift
//  Scope-Limited Calendar
//
//  Created by Jessica Linden on 2/18/22.
//

import SwiftUI

@main
struct Scope_Limited_CalendarApp: App {
  @StateObject var calendarManager = CalendarManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
            .environmentObject(calendarManager)
        }
    }
}
