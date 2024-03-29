//
//  CrewRoster.swift
//  Moonshot
//
//  Created by Fahad Mansuri on 19.02.24.
//  Challenge 2

import SwiftUI

struct CrewRoster: View {
    let crew: [MissionView.CrewMember]
    
    var body: some View {
        ScrollView(.horizontal){
            HStack{
                ForEach(crew, id: \.role){ crewMember in
                    NavigationLink{
                        AstronautView(astronaut: crewMember.astronaut)
                    } label: {
                        VStack{
                            Image(crewMember.astronaut.id)
                                .resizable()
                                .frame(width: 208, height: 144)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .overlay {
                                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                                        .strokeBorder(.white, lineWidth: 1)
                                }
                            
                            VStack(alignment: .leading){
                                Text(crewMember.astronaut.name)
                                    .foregroundStyle(.white)
                                    .font(.headline)
                                Text(crewMember.role)
                                    .foregroundStyle(.gray)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
}

struct CrewRoster_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            CrewRoster(
                crew: [
                    MissionView.CrewMember(
                        role: "Commander",
                        astronaut: Astronaut(
                            id: "armstrong",
                            name: "Neil A. Armstrong",
                            description: "")
                    ),
                ]
            )
        }
        .preferredColorScheme(.dark)
    }
}
