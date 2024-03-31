//
//  ContentView.swift
//  FriendFace
//
//  Created by Fahad Mansuri on 21.03.24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @AppStorage("lastFetched") private var lastFetched: Double = Date.now.timeIntervalSince1970
    @Query(sort: \User.id) private var users: [User]
    @State private var sortOrder = [SortDescriptor(\User.id), SortDescriptor(\User.name)]
    
    var body: some View {
        NavigationStack {
            List(users) {user in
                NavigationLink{
                    DetailView(user: user)
                } label: {
                    HStack{
                        Image(systemName: "person.circle")
                            .foregroundStyle(user.isActive ? .green : .red)
                            .font(.title)
                        Text(user.name)
                            .font(.subheadline)
                    }
                }
            }
            .navigationTitle("FriendFace")
        }
        .task {
            do {
                if hasExceededLimit() || users.isEmpty {
                    clearPhotos()
                    try await getUser()
                }
            } catch GHError.fetchFailed {
                print("Data cannot be fetched")
            } catch {
                print("\(error.localizedDescription)")
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("by Name")
                            .tag([SortDescriptor(\User.name), SortDescriptor(\User.id)])
                        Text("by ID")
                            .tag([SortDescriptor(\User.id), SortDescriptor(\User.name)])
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [User.self])
}

extension ContentView {
    func getUser() async throws {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let users = try decoder.decode([User].self, from: data)
            users.forEach { modelContext.insert ($0)}
            lastFetched = Date.now.timeIntervalSince1970
        } catch {
            print("User fetch failed: \(error.localizedDescription)")
            throw GHError.fetchFailed
        }
    }
    
    enum GHError: Error {
        case fetchFailed
    }
    
    func hasExceededLimit() -> Bool {
        let timelimit = 300
        let currentTime = Date.now
        let lastFetchedTime = Date(timeIntervalSince1970: lastFetched)
        
        guard let differenceInMins = Calendar.current.dateComponents([.second], from: lastFetchedTime, to: currentTime).second else {
            return false
        }
        return differenceInMins >= timelimit
    }
    
    func clearPhotos() {
        try? modelContext.delete(model: User.self)
    }
    
    init(sortOrder: [SortDescriptor<User>], itemType: String) {
        _users = Query(sort: sortOrder)
    }
}
