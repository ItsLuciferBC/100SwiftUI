//
//  ContentView.swift
//  Word Scramble
//
//  Created by Fahad Mansuri on 24.12.23.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var userScore = 0
    
    var body: some View {
        NavigationStack{
            List{
                Section{
                    TextField("Enter a word", text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                
                Section("Your Score"){
                    Text("\(userScore) points")
                }
                .font(.headline)
                
                Section{
                    ForEach(usedWords, id: \.self){word in
                        HStack{
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .foregroundStyle(.primary)
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError) {
                Button("OK"){}
            } message: {
                Text(errorMessage)
            }
        }
        Button("Restart game", action: startGame)
            .foregroundStyle(.primary)
    }
    
    func addNewWord(){
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 2 else {
            wordError(title: "Word too short", message: "Please enter a word having more than 2 letters")
            return
        }
        
        guard answer != rootWord else {
            wordError(title: "Word is unacceptable", message: "You cannot just enter the root word again")
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Come on... be original")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that from \(rootWord)!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not real", message: "That's not even a real word. Don't make em up")
            return
        }
        
        withAnimation{
            usedWords.insert(answer, at: 0)
        }
        userScore += 1
        newWord = ""
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: ".txt"){
            if let startWords = try? String(contentsOf: startWordsURL){
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                userScore = 0
                usedWords.removeAll()
                return
            }
        }
        
        fatalError("Could not load start.txt from the Bundle")
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter){
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String){
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

#Preview {
    ContentView()
}
