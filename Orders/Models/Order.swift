//
//  Order.swift
//  Orders
//
//  Created by Pedro Paramo on 1/30/20.
//  Copyright © 2020 Pedro Paramo. All rights reserved.
//

import Foundation

enum CoffeType: String, Codable {
    case cappuccino
    case latte
    case espressino
    case cortado
}

enum CoffeSize: String, Codable {
    case small
    case medium
    case large
}

struct Order: Codable{
    let name: String
    let email: String
    let type: CoffeType
    let size: CoffeSize
}
