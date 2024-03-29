//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Fahad Mansuri on 18.03.24.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
