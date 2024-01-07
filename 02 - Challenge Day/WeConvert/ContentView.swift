//
//  ContentView.swift
//  WeConvert
//
//  Created by Fahad Mansuri on 30.10.23.
//

import SwiftUI

struct ContentView: View {
    @State private var inputVal = 0.0
    @State private var fromVal = "Celsius"
    @State private var toVal = "Fahrenheit"
    
    @State private var units = ["Celsius", "Fahrenheit", "Kelvin"]
    
    var outputVal: Double {
        switch (fromVal, toVal){
        case ("Celsius", "Fahrenheit"):
            (inputVal * (9/5) + 32)
        case ("Celsius", "Kelvin"):
            (inputVal + 273.15)
        case ("Fahrenheit", "Celsius"):
            (inputVal - 32) * 5/9
        case ("Fahrenheit", "Kelvin"):
            (inputVal - 32) * 5/9 + 273.15
        case ("Kelvin", "Celsius"):
            inputVal - 273.15
        case ("Kelvin", "Fahrenheit"):
            ((inputVal - 273.15) * 9/5 + 32)
        default:
            0.0
        }
    }
    
    
    var body: some View {
        NavigationStack{
            Form{
                Section("Enter the value to be converted"){
                    TextField("value", value: $inputVal, format: .number)
                }
                Section("From"){
                    Picker("From", selection: $fromVal){
                        ForEach(units, id: \.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("To"){
                        Picker("To", selection: $toVal){
                            ForEach(units, id: \.self){
                                Text($0)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                Section("Output value"){
                    Text("\(outputVal.formatted())")
                }
                }
            .navigationTitle("WeConvert")
            }
        }
    }


#Preview {
    ContentView()
}
