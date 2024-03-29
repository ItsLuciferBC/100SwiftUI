//
//  ContentView.swift
//  Moonshot
//
//  Created by Fahad Mansuri on 06.02.24.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")

    @AppStorage("showingGrid") private var showingGrid = true
    
    var body: some View {
        NavigationStack{
            
            //Challenge 3
            Group{
                if showingGrid{
                    GridLayout(astronauts: astronauts, missions: missions)
                } else{
                    ListLayout(astronauts: astronauts, missions: missions)
                }
            }
            .toolbar {
                Button {
                    withAnimation {
                        showingGrid.toggle()
                    }
                } label: {
                    Image(systemName: showingGrid ? "list.bullet" : "square.grid.2x2")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
