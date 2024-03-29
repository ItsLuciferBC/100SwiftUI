//
//  AddView.swift
//  iExpense
//
//  Created by Fahad Mansuri on 03.02.24.
//

import SwiftUI
import SwiftData

struct AddView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    
//    var expenses: Expenses
    
    let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationStack{
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                //Challenge 1
                TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
            }
            .toolbar{
                Button("Save"){
                    let item = Expenses(id: UUID(), name: name, type: type, amount: amount)
                    modelContext.insert(item)
                    dismiss()
                }
            }
            .navigationTitle("Add Expense")
        }
    }
}

#Preview {
    AddView()
}
