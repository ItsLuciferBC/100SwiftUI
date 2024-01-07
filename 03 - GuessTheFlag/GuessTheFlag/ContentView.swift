//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Fahad Mansuri on 30.10.23.
//

import SwiftUI

struct FlagImage: View {
    let countryName: String
    
    var body: some View {
        Image(countryName)
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .shadow(radius: 5)
    }
}

struct cusTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.blue)
    }
}

extension View {
    func cusTitleStyle() -> some View {
        modifier(cusTitle())
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var userScore = 0
    @State private var questionCounter = 1
    @State private var finalScore = false
    
    var body: some View {
        ZStack{
            RadialGradient(
                stops: [
                    .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                    .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
                ],
                center: .top,
                startRadius: 200,
                endRadius: 400
            )
            .ignoresSafeArea()
            
            VStack(spacing: 15){
                Spacer()
                Text("Guess The Flag")
                //                    .cusTitleStyle()
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                Spacer()
                VStack {
                    Text("Tap the flag of")
                        .foregroundStyle(.secondary)
                        .font(.headline.weight(.heavy))
                    Text(countries[correctAnswer])
                        .foregroundStyle(.black)
                        .font(.largeTitle.weight(.semibold))
                    
                    ForEach(0..<3){number in
                        Button{
                            flagTapped(number)
                        } label: {
                            FlagImage(countryName: countries[number])
                        }
                        .alert(scoreTitle, isPresented: $showingScore) {
                            if questionCounter == 8 {
                                Button("Continue", action: reset)
                            } else {
                                Button("Continue", action: askQuestion)
                            }
                        } message: {
                            if questionCounter == 8{
                                Text("Game over.. Your final score is \(userScore)")
                            } else {
                                Text("Your score is \(userScore)")
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                //Challenge 1
                Text("Score: \(userScore)")
                    .font(.title.bold())
                    .foregroundStyle(.white)
                
                //Challenge 3
                Text("Round: \(questionCounter)")
                    .font(.headline)
                    .foregroundStyle(.white)
                Spacer()
            }
            .padding()
        }
    }
    
    //Challenge 2
    func flagTapped (_ number: Int){
        if number == correctAnswer{
            scoreTitle = "Correct"
            userScore += 1
        } else {
            scoreTitle = "Wrong, That is the flag of \(countries[number])"
        }
        
        showingScore = true
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        questionCounter += 1
    }
    
    func reset(){
        askQuestion()
        questionCounter = 0
        userScore = 0
    }
}

#Preview {
    ContentView()
}
