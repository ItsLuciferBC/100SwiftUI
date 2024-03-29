//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Fahad Mansuri on 02.02.24.
//

import SwiftUI
import SwiftData

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Expenses.self)
    }
}
