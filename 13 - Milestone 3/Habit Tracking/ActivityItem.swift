//
//  Activity.swift
//  Habit Tracking
//
//  Created by Fahad Mansuri on 06.03.24.
//

import Foundation

struct ActivityItem: Identifiable, Codable {
    var id = UUID()
    var name: String
    var desc: String
    var count: Int
}

class Activities: ObservableObject {
    @Published var items = [ActivityItem](){
        didSet {
            if let encoded = try? JSONEncoder().encode(items){
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items"){
            if let decodedItems = try? JSONDecoder().decode([ActivityItem].self, from: savedItems){
                items = decodedItems
                return
            }
        }
        
        items = []
    }
}
