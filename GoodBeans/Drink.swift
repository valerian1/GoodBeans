//
//  Drink.swift
//  GoodBeans
//
//  Created by VLR on 08/01/22.
//

import Foundation

struct Drink: Identifiable, Codable {
    let id: UUID
    let name: String
    let caffeine: [Int]
    let coffeeBased: Bool
    let servedWithMilk: Bool
    let baseCalories: Int
    
    var image: String {
        name.lowercased().replacingOccurrences(of: " ", with: "-")
    }
    
    static let example = Drink(id: UUID(), name: "Example Data", caffeine: [60, 120, 200], coffeeBased: true, servedWithMilk: true, baseCalories: 100)
}
