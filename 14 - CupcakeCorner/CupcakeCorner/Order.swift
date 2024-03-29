//
//  Order.swift
//  CupcakeCorner
//
//  Created by Fahad Mansuri on 10.03.24.
//

import SwiftUI

@Observable
class Order: Codable {
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name: String {
        didSet {
            if let encoded = try? JSONEncoder().encode(name) {
                UserDefaults.standard.setValue(encoded, forKey: "Name")
            }
        }
    }
    var streetAddress: String {
        didSet {
            if let encoded = try? JSONEncoder().encode(streetAddress) {
                UserDefaults.standard.setValue(encoded, forKey: "Address")
            }
        }
    }
    var city: String {
        didSet {
            if let encoded = try? JSONEncoder().encode(city) {
                UserDefaults.standard.setValue(encoded, forKey: "City")
            }
        }
    }
    var zip: String {
        didSet {
            if let encoded = try? JSONEncoder().encode(zip) {
                UserDefaults.standard.setValue(encoded, forKey: "Zip")
            }
        }
    }
    
    var hasValidAddress: Bool {
        //Project 10: Challenge 1
        if name.isEmpty || name.hasPrefix(" ") || name.hasSuffix(" ") ||
            streetAddress.isEmpty || streetAddress.hasPrefix(" ") || streetAddress.hasSuffix(" ") || 
            city.isEmpty || city.hasPrefix(" ") || city.hasSuffix(" ") ||
            zip.isEmpty || zip.hasPrefix(" ") || zip.hasSuffix(" ") {
            return false
        } else {
            return true
        }
    }
    
    var cost: Decimal {
        // $2 per cake
        var cost = Decimal(quantity) * 2
        
        //complicated costs more
        cost += Decimal(type)/2
        
        // $1 per cake for extra frosting
        if extraFrosting {
            cost += Decimal(quantity)
        }
        
        // $0.50 per cake for sprinkles
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }
        
        return cost
    }
    
    //Project 10: Challenge 3
    init(){
        name = ""
        streetAddress = ""
        city = ""
        zip = ""
        
        if let savedItems = UserDefaults.standard.data(forKey: "Name") {
            if let decodedItems = try? JSONDecoder().decode(String.self, from: savedItems) {
                name = decodedItems
//                return
            }
        }
        if let savedItems = UserDefaults.standard.data(forKey: "Address") {
            if let decodedItems = try? JSONDecoder().decode(String.self, from: savedItems) {
                streetAddress = decodedItems
//                return
            }
        }
        if let savedItems = UserDefaults.standard.data(forKey: "City") {
            if let decodedItems = try? JSONDecoder().decode(String.self, from: savedItems) {
                city = decodedItems
//                return
            }
        }
        if let savedItems = UserDefaults.standard.data(forKey: "Zip") {
            if let decodedItems = try? JSONDecoder().decode(String.self, from: savedItems) {
                zip = decodedItems
                return
            }
        }
    }
}
