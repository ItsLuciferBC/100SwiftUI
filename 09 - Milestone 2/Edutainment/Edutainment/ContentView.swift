//
//  ContentView.swift
//  Edutainment
//
//  Created by Fahad Mansuri on 28.01.24.
//

import SwiftUI
struct Question {
    var text: String
    var answer: Int
}

struct ContentView: View {
    //For Question and answers
    @State private var tableNum = 2
    @State private var numberOfQuestions = 10
    @State private var currentQuestion = 0
    let difficulty = [5, 10, 20]
    @State private var score = 0
    @State private var quizQ = [String]()
    @State private var quizA = [Int]()
    @State private var userAnswer = ""
    // For Animation
    @State private var finalScore = ""
    @State private var scale = 1.0
    let assets = ["bear", "buffalo", "chick", "chicken", "cow", "crocodile", "dog", "duck", "elephant", "frog", "giraffe", "goat", "gorilla", "hippo", "horse", "monkey", "moose", "narwhal", "owl", "panda", "parrot", "penguin", "pig", "rabbit", "rhino", "sloth", "snake", "walrus", "whale", "zebra"]
    @State private var imageName = "bear"
    @State private var animateGradient = false
    
    var body: some View {
        NavigationStack{
            ZStack{
                VStack {
                    Section("Pick a number"){
                        Picker("Table number", selection: $tableNum) {
                            ForEach(2...12, id: \.self){
                                Text("\($0)")
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    .font(.largeTitle)
                    .fontDesign(.monospaced)
                    
                    Section("Difficulty"){
                        Picker("Choose difficulty", selection: $numberOfQuestions) {
                            ForEach(difficulty, id: \.self){
                                Text("\($0)")
                            }
                        }
                        .pickerStyle(.palette)
                    }
                    .fontDesign(.monospaced)
                    .font(.headline)
                    Spacer()
                    if !finalScore.isEmpty{
                        Text("""
                        \(finalScore)
                        
                        Press start
                        """)
                        .fontDesign(.monospaced)
                        .fontWeight(.bold)
                        .font(.largeTitle)
                    }
                    Image(imageName)
                        .scaleEffect(scale)
                        .onAppear(){
                            let baseAnimation = Animation.easeInOut(duration: 1)
                            let repeated = baseAnimation.repeatForever(autoreverses: true)
                            
                            withAnimation(repeated){
                                scale = 0.8
                            }
                        }
                    Spacer()
                    Section{
                        if !quizQ.isEmpty{
                            Text("\(quizQ[currentQuestion])")
                                .font(.title3)
                            TextField("Enter answer", text: $userAnswer)
                                .onSubmit {
                                    imageName = assets[Int.random(in: 0...29)]
                                    if currentQuestion + 1 < numberOfQuestions{
                                        checkAnswer()
                                    }
                                    else {
                                        finalScore = "Your final score: \(score)"
                                        reset()
                                    }
                                }
                                .frame(maxWidth: .infinity)
                                .padding(20)
                                .background(.regularMaterial)
                                .clipShape(.rect(cornerRadius: 20))
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.numberPad)
                        }
                    }
                    Text("Your Score: \(score). Round: \(currentQuestion + 1)")
                        .fontDesign(.monospaced)
                }
                .padding()
                .toolbar{
                    Button("Start") {
                        print("Start tapped")
                        startGame()
                    }
                    .foregroundStyle(.black)
                }
            }
            .background(){
                RadialGradient(colors: [.yellow, .green], center: UnitPoint(x: 0, y: 0), startRadius: 300, endRadius: 800)
                    .ignoresSafeArea()
                    .hueRotation(.degrees(animateGradient ? 30 : 0))
                    .onAppear(){
                        withAnimation(.easeInOut(duration: 3).repeatForever()){
                            animateGradient.toggle()
                        }
                    }
            }
        }
    }
    
    func startGame(){
        reset()
        finalScore = ""
        let a = tableNum
        var b = numberOfQuestions
        while (b > 0){
            let random = Int.random(in: 0...12)
            quizQ.append("What is \(a) x \(random)")
            quizA.append(a * random)
            b -= 1
        }
        print(quizQ)
        print(quizA)
    }
    
    func checkAnswer(){
        if (Int(userAnswer) == quizA[currentQuestion] && currentQuestion < numberOfQuestions){
            score += 1
            currentQuestion += 1
            userAnswer = ""
        } else if (Int(userAnswer) != quizA[currentQuestion] && currentQuestion < numberOfQuestions){
            currentQuestion += 1
            userAnswer = ""
        }
    }
    
    func reset(){
        score = 0
        currentQuestion = 0
        quizQ.removeAll()
        quizA.removeAll()
    }
}

#Preview {
    ContentView()
}
