//
//  MenuSection.swift
//  GoodBeans
//
//  Created by VLR on 08/01/22.
//

import Foundation

struct MenuSection: Identifiable, Codable {
    let id: UUID
    let name: String
    let drinks: [Drink]
}
