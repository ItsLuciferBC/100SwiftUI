//
//  DetailView.swift
//  FriendFace
//
//  Created by Fahad Mansuri on 21.03.24.
//

import SwiftUI

struct DetailView: View {
    let user: User
    var body: some View {
        NavigationStack {
            Form {
                HStack(alignment: .top) {
                    VStack {
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(width: 60, height: 60)
                            .foregroundStyle(user.isActive ? .green : .red)
                            .padding()
                        Text(user.name)
                            .font(.title)
                    }
                    .padding()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .listRowInsets(EdgeInsets())
                
                Section("Personal details") {
                    List {
                        HStack {
                            Text("Age")
                            Spacer()
                            Text("\(user.age)")
                        }
                    }
                }
                
                Section("Professional details") {
                    List {
                        HStack {
                            Text("Email")
                            Spacer()
                            Text(user.email)
                        }
                        HStack {
                            Text("Company")
                            Spacer()
                            Text(user.company)
                        }
                        HStack {
                            Text("Date Joined")
                            Spacer()
                            Text("\(user.registered.formatted(date: .abbreviated, time: .omitted))")
                        }
                    }
                }
                
                Section("Abput") {
                    Text(user.about)
                }
                
                Section("Friends") {
                    ForEach(user.friends) { friend in
                        Text(friend.name)
                    }
                }
            }
        }
    }
}

#Preview {
    DetailView(user: User(id: "ID", isActive: false, name: "testName", age: 18, company: "testCompany", email: "testEmail", address: "testAddress", about: "testAbout", registered: Date.now, friends: [Friend]()))
}
