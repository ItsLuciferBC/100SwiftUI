//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Fahad Mansuri on 10.03.24.
//

import SwiftUI

struct CheckoutView: View {
    var order: Order
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    @State private var checkoutFailed = false //Project 10: Challenge 2
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(height: 233)
                    
                    Text("Your total is \(order.cost, format: .currency(code: "EUR"))")
                        .font(.title)
                    
                    Button("Place order"){
                        Task {
                            await placeOrder()
                        }
                    }
                        .padding()
                }
            }
            .scrollBounceBehavior(.basedOnSize)
            .navigationTitle("Checkout")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Thank you", isPresented: $showingConfirmation) {
                Button("OK"){}
            } message: {
                Text(confirmationMessage)
            }
            //Project 10: Challenge 2
            .alert("Checkout Failed", isPresented: $checkoutFailed) {
                Button("OK") {}
            } message: {
                Text("Please try again")
            }
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
        } catch {
            print("Checkout failed: \(error.localizedDescription)")
            checkoutFailed = true //Project 10: Challenge 2
        }
    }
}

#Preview {
    CheckoutView(order: Order())
}