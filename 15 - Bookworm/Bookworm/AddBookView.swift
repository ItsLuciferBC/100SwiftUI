//
//  AddBookView.swift
//  Bookworm
//
//  Created by Fahad Mansuri on 14.03.24.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var emptyAlert = false
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Fantasy"
    @State private var review = ""
    var genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    @State private var date = Date()
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Title", text: $title)
                    TextField("Author", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section("Write a review") {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                }
                
                Section {
                    Button("Add review"){
                        //Project 11: Challenge 1
                        if (title.hasPrefix(" ") || title.hasSuffix(" ") || title == "" || author.hasPrefix(" ") || author.hasSuffix(" ") || author == "" || review.hasPrefix(" ") || review.hasSuffix(" ") || review == "") {
                            emptyAlert = true
                        } else {
                            let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating, dateAdded: date)
                            modelContext.insert(newBook)
                            dismiss()
                        }
                    }
                }
            }
            .navigationTitle("Add Book")
            .alert("Missing Information", isPresented: $emptyAlert) {
                Button ("Okay") {}
            } message: {
                Text("Please fill all the fields")
            }
        }
    }
}

#Preview {
    AddBookView()
}
