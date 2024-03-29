//
//  ContentView.swift
//  iExpense
//
//  Created by Fahad Mansuri on 02.02.24.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable class Expenses {
    var items = [ExpenseItem](){
        didSet {
            if let encoded = try? JSONEncoder().encode(items){
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init(){
        if let savedItems = UserDefaults.standard.data(forKey: "Items"){
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems){
                items = decodedItems
                return
            }
        }
        
        items = []
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationStack{
            TabView{
                List{
                    ForEach(expenses.items){item in
                        if item.type == "Personal"{
                            HStack{
                                VStack{
                                    Text(item.name)
                                        .font(.headline)
                                    Text(item.type)
                                }
                                
                                Spacer()
                                
                                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                    .foregroundColor(item.amount <= 10 ? .green : item.amount <= 100 ? .yellow : .red) // Challenge 2
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
                    ForEach(expenses.items){item in
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
            .navigationTitle("iExpense")
            .toolbar{
                Button("Add item", systemImage: "plus"){
                    showingAddExpense = true
                }
                .navigationDestination(isPresented: $showingAddExpense) {
                    AddView(expenses: expenses)
                }
            }
//            .sheet(isPresented: $showingAddExpense){
//                AddView(expenses: expenses)
//            }
        }
    }
    
    func removeItems(at offsets: IndexSet){
        expenses.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
