//
//  CustomizeView.swift
//  GoodBeans
//
//  Created by VLR on 14/01/22.
//

import SwiftUI

struct CustomizeView: View {
    let drink: Drink
    
    @EnvironmentObject var menu: Menu
    @EnvironmentObject var history: History
    
    @State private var size = 1
    @State private var isDecaf = false
    @State private var extraShots = 0
    @State private var milk = ConfigurationOption.none
    @State private var syrup = ConfigurationOption.none
    
    let sizeOptions = ["Small", "Medium", "Large"]
    
    var caffeine: Int {
        var caffeineAmount = drink.caffeine[size]
        caffeineAmount += (extraShots * 60)
        
        if isDecaf {
            caffeineAmount /= 20
        }
        
        return caffeineAmount
    }
    
    var calories: Int {
        var calorieAmount = drink.caffeine[size]
        calorieAmount = extraShots * 10
        
        if drink.coffeeBased {
            calorieAmount += milk.calories
        } else {
            calorieAmount += milk.calories / 8
        }
        
        calorieAmount += syrup.calories
        return calorieAmount * (size + 1)
    }
    
    var body: some View {
        Form {
            Image(drink.image)
                .resizable()
                .scaledToFill()
                .cornerRadius(10)
            Section("Basic options") {
                Picker("Size", selection: $size) {
                    ForEach(sizeOptions.indices) { index in
                        Text(sizeOptions[index])
                    }
                }
                .pickerStyle(.segmented)
                
                if drink.coffeeBased {
                    Stepper("Extra shots: \(extraShots)", value: $extraShots, in: 0...8)
                }
                
                Toggle("Decaffeinated", isOn: $isDecaf)
            }
            
            Section("Customizations") {
                Picker("Milk", selection: $milk) {
                    ForEach(menu.milkOptions) { option in
                        Text(option.name)
                            .tag(option)
                    }
                }
                
                if drink.coffeeBased {
                    Picker("Syrop", selection: $syrup) {
                        ForEach(menu.syrupOptions) { option in
                            Text(option.name)
                                .tag(option)
                        }
                    }
                }
            }
            
            Section("Estimates") {
                Text("**Caffeine:** \(caffeine)mg")
                Text("**Calories:** \(calories)")
            }
            
            Button("ORDER") {
                history.add(drink, size: sizeOptions[size], extraShots: extraShots, isDecaf: isDecaf, milk: milk, syrop: syrup, caffeine: caffeine, calories: calories)
                
            }
            .buttonStyle(.bordered)
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(drink.name)
        
    }
}

struct CustomizeView_Previews: PreviewProvider {
    static var previews: some View {
        CustomizeView(drink: Drink.example)
            .environmentObject(Menu())
    }
}
