//
//  ExpenseView.swift
//  iExpense
//
//  Created by Fahad Mansuri on 20.03.24.
//

import SwiftUI
import SwiftData

struct ExpenseView: View {
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [Expenses]
    
    var body: some View {
        TabView{
            List{
                ForEach(expenses){item in
                    if item.type == "Personal"{
                        HStack{
                            VStack{
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            
                            Spacer()
                            
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                .foregroundColor(item.amount <= 10 ? .green : item.amount <= 100 ? .yellow : .red)
                        }
                    }
                }
                .onDelete(perform: removeItems)
            }
            .tabItem {
                Image(systemName: "cart")
                Text("Personal")
            }
            
            List{
                ForEach(expenses){item in
                    if item.type == "Business"{
                        HStack{
                            VStack{
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            
                            Spacer()
                            
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                .foregroundColor(item.amount <= 10 ? .green : item.amount <= 100 ? .yellow : .red)
                        }
                    }
                }
                .onDelete(perform: removeItems)
            }
            .tabItem {
                Image(systemName: "suitcase")
                Text("Business")
            }
        }
    }
    
    init(sortOrder: [SortDescriptor<Expenses>], itemType: String) {
        _expenses = Query(sort: sortOrder)
    }
    
    func removeItems(at offsets: IndexSet){
        for offset in offsets {
            let expense = expenses[offset]
            modelContext.delete(expense)
        }
    }

}

#Preview {
    ExpenseView(sortOrder: [SortDescriptor(\Expenses.id)], itemType: "Personal")
        .modelContainer(for: Expenses.self)
}
