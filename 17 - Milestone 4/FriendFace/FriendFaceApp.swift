//
//  FriendFaceApp.swift
//  FriendFace
//
//  Created by Fahad Mansuri on 21.03.24.
//

import SwiftUI
import SwiftData

@main
struct FriendFaceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [User.self])
    }
}
