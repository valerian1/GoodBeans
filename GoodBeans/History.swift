//
//  History.swift
//  GoodBeans
//
//  Created by VLR on 24/01/22.
//

import Foundation

class History: ObservableObject {
    @Published var servings : [Serving]
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedDrinks")
    
    init () {
        do {
            let data = try Data(contentsOf: savePath)
            servings = try JSONDecoder().decode([Serving].self, from: data)
        } catch {
            servings = []
        }
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(servings)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data")
        }
    }
    
    func add(_ drink: Drink, size: String, extraShots: Int, isDecaf: Bool, milk: ConfigurationOption, syrop: ConfigurationOption, caffeine: Int, calories: Int) {
        var description = [String]()
        description.append(size)
        
        if isDecaf {
            description.append("decaffeinated")
        }
        
        switch extraShots {
        case 0:
            break
        case 1:
            description.append("1 extra shot")
        default:
            description.append("\(extraShots) extraShots")
        }
        
        if milk != .none {
            description.append("\(milk.name.lowercased()) milk")
        }
        
        if syrop != .none {
            description.append("\(syrop.name.lowercased()) syrop")
        }
        
        let descriptionString = description.joined(separator: ", ")
        
        let serving = Serving(id: UUID(), name: drink.name, description: descriptionString, caffeine: caffeine, calories: calories)
        servings.insert(serving, at: 0)
        save()
    }
}
