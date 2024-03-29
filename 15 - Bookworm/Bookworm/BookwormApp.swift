//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Fahad Mansuri on 11.03.24.
//

import SwiftUI
import SwiftData

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
