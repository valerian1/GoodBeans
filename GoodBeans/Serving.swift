//
//  Serving.swift
//  GoodBeans
//
//  Created by VLR on 24/01/22.
//

import Foundation

struct Serving: Identifiable, Codable {
    var id: UUID
    let name: String
    let description: String
    let caffeine: Int
    let calories: Int
}
