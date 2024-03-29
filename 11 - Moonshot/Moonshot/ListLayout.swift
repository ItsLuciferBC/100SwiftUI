//
//  ListLayout.swift
//  Moonshot
//
//  Created by Fahad Mansuri on 19.02.24.
//

import SwiftUI

struct ListLayout: View {
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    let columns = [
        GridItem(.adaptive(minimum: 300, maximum: .infinity))
    ]
    
    var body: some View {
        ScrollView{
            LazyVGrid(columns: columns){
                ForEach(missions){mission in
                    NavigationLink{
                        MissionView(mission: mission, astronauts: astronauts)
                    } label: {
                        VStack{
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()
                            
                            VStack{
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundStyle(.white)
                                
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(.lightBackground)
                        }
                        .background(.darkBackground)
                        .clipShape(.rect(cornerRadius: 10))
                        .overlay{
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground)
                        }
                        .padding(.horizontal)
                    }
                }
                .navigationTitle("Moonshot")
                .preferredColorScheme(.dark)
            }
        }
    }
}

struct ListLayout_Previews: PreviewProvider{
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View{
        ListLayout(astronauts: astronauts, missions: missions)
    }
}
