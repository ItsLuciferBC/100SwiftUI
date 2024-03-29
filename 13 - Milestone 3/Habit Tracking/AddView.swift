//
//  AddView.swift
//  Habit Tracking
//
//  Created by Fahad Mansuri on 06.03.24.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var desc = ""
    @State private var count = 0
    @State private var showingAlert = false
    
    var activities : Activities
    
    var body: some View {
        NavigationStack{
            Form{
                TextField("Name", text: $name)
                TextField("Description", text: $desc)
                Stepper("Count: \(count)", value: $count, in: 0...5)
                    .foregroundStyle(count == 0 ? .red : .primary)
            }
            .navigationTitle("Add Activity")
            .toolbar{
                Button("Done"){
                    if (name != "" && count != 0){
                        let item = ActivityItem(name: name, desc: desc, count: count)
                        activities.items.append(item)
                        dismiss()
                    } else {
                        self.showingAlert.toggle()
                    }
                }
                .alert(isPresented: $showingAlert, content: {
                    Alert(title: Text("OOPS"), message: Text("Name or Count cannot be empty"))
                })
            }
        }
    }
}

#Preview {
    AddView(activities: Activities())
}
