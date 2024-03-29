//
//  ActivityView.swift
//  Habit Tracking
//
//  Created by Fahad Mansuri on 06.03.24.
//

import SwiftUI

struct ActivityView: View {
    @ObservedObject var activities : Activities
    var index: UUID
    
    var body: some View {
        NavigationStack{
            Form{
                ForEach(activities.items){item in
                    if (item.id == index){
                        Text("Activity: \(item.name)")
                        Text("Description: \(item.desc)")
                        
                        HStack{
                            Button("Mark Completed"){
                                print(item.count)
                            }
                            Text("\(item.count)")
                        }
                    }
                }
            }
            .navigationTitle("Summary")
        }
    }
}

#Preview {
    ActivityView(activities: Activities(), index: UUID())
}
