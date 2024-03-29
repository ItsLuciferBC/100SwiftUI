//
//  ContentView.swift
//  Habit Tracking
//
//  Created by Fahad Mansuri on 06.03.24.
//

import SwiftUI

struct ContentView: View {
    @State private var activities = Activities()
    @State private var showingSheet = false
    
    var body: some View {
        NavigationStack{
            List{
                ForEach(activities.items){item in
                    NavigationLink {
                        ActivityView(activities: activities, index: item.id)
                    } label: {
                        HStack{
                            VStack(alignment: .leading){
                                Text(item.name)
                                    .font(.title)
                                    .onTapGesture {
                                        print(item.name)
                                    }
                                Text(item.desc)
                                    .font(.subheadline)
                            }
                            Spacer()
                            HStack{
                                Image(systemName: "flag.fill")
                                Text(String(item.count))
                            }
                        }
                    }
                }
                .onDelete(perform: { indexSet in
                    activities.items.remove(atOffsets: indexSet)
                })
            }
            .navigationTitle("Habit Tracker")
            .toolbar{
                Button("Add item", systemImage: "plus") {
                    showingSheet = true
                }
            }
            .sheet(isPresented: $showingSheet, content: {
                AddView(activities: activities)
            })
        }
    }
}

#Preview {
    ContentView()
}
