//
//  ContentView.swift
//  Rock, Paper, Scissors
//
//  Created by Fahad Mansuri on 14.12.23.
//

import SwiftUI

struct ContentView: View {
    let moves = ["Rock", "Paper", "Scissor"]
    let winMove = ["Scissor", "Rock", "Paper"]
    let loseMove = ["Paper", "Scissor", "Rock"]
    @State var move = Int.random(in: 0...2)
    @State var con = Bool.random()
    @State var userScore = 0
    @State var rounds = 1
    @State var showingScore = false
    
    var body: some View {
        ZStack{
            LinearGradient(colors: [.pink, .orange], startPoint: .bottom, endPoint: .top)
                .ignoresSafeArea()
            VStack {
                Spacer()
                
                Text("Score \(userScore)")
                    .font(.title)
                    .foregroundStyle(.black)
                Text("Round \(rounds)")
                    .foregroundStyle(.black)
                
                    Spacer()
                
                    switch moves[move]  {
                    case "Rock":
                        Image("rock")
                            .resizable()
                            .frame(width: 500)
                            .imageScale(.small)
                    case "Paper":
                        Image("paper")
                            .resizable()
                            .frame(width: 500)
                            .imageScale(.small)
                    case "Scissor":
                        Image("scissor")
                            .resizable()
                            .frame(width: 500)
                            .imageScale(.small)
                    default:
                        Image(systemName: "car")
                    }
                
                if con {
                    Text("How to WIN this round?")
                        .foregroundStyle(.black)
                        .font(.title2.bold())
                } else {
                    Text("How to LOSE this round")
                        .foregroundStyle(.black)
                        .font(.title2.bold())
                }
                
                HStack{
                    ForEach(0..<3){number in
                        Button{
                            buttonTapped(number)
                            nextRound()
                        } label: {
                            Text(moves[number])
                                .font(.system(size: 30))
                        }
                        .alert("Game Over", isPresented: $showingScore){
                            if (rounds >= 7){
                                Button("Continue", action : reset)
                            }
                        } message: {
                            if (rounds >= 7){
                                Text("Your Score is \(userScore)")
                            }
                        }
                        .buttonStyle(.bordered)
                        .font(.caption)
                        .foregroundStyle(.black)
                        .backgroundStyle(.thickMaterial)
                    }
                }
                Spacer()
            }
            .padding()
        }
    }
    
    func buttonTapped(_ number: Int){
        if(rounds > 7){
            showingScore = true
            return
        }
        if (winMove[number] == moves[move] && con == true){
            userScore+=1
        } else if(loseMove[number] == moves[move] && con == false) {
            userScore+=1
        }
    }
    
    func nextRound(){
        move = Int.random(in: 0...2)
        con = Bool.random()
        rounds += 1
    }
    
    func reset(){
        userScore = 0
        rounds = 0
    }
}

#Preview {
    ContentView()
}
