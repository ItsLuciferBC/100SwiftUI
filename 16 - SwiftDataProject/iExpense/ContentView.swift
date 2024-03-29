//
//  ContentView.swift
//  iExpense
//
//  Created by Fahad Mansuri on 02.02.24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var sortOrder = [SortDescriptor(\Expenses.name), SortDescriptor(\Expenses.amount)]
    @State private var sortByName = false
    @State private var showingAddExpense = false
    let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationStack{
            ExpenseView(sortOrder: sortOrder, itemType: "Personal")
            .navigationTitle("iExpense")
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    Menu("Sort", systemImage: "arrow.up.arrow.down") {
                        Picker("Sort", selection: $sortOrder) {
                            Text("Sort by Name")
                                .tag([SortDescriptor(\Expenses.name), SortDescriptor(\Expenses.amount)])
                            
                            Text("Sort by Amount")
                                .tag([SortDescriptor(\Expenses.amount), SortDescriptor(\Expenses.name)])
                        }
                    }
                }
                
                ToolbarItem(placement:.topBarTrailing){
                    Button("Add item", systemImage: "plus"){
                        showingAddExpense = true
                    }
                }
                
            }
            .sheet(isPresented: $showingAddExpense){
                AddView()
            }
        }
    }
}

#Preview {
    ContentView()
}
