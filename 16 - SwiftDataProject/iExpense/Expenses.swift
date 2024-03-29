//
//  Expenses.swift
//  iExpense
//
//  Created by Fahad Mansuri on 20.03.24.
//

import Foundation
import SwiftData

@Model
class Expenses: Identifiable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
    
    init(id: UUID = UUID(), name: String, type: String, amount: Double) {
        self.id = id
        self.name = name
        self.type = type
        self.amount = amount
    }
}
