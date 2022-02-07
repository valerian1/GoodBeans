//
//  ContentView.swift
//  GoodBeans
//
//  Created by VLR on 08/01/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var menu = Menu()
    @StateObject var history = History()
    
    var body: some View {
        MenuView()
            .environmentObject(menu)
            .environmentObject(history)
            // STARTING HERE TO MAKE CHANGES
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
