//
//  Cart.swift
//  PizzaApp
//
//  Created by Evandro Harrison Hoffmann on 10/4/18.
//  Copyright © 2018 It's Day Off. All rights reserved.
//

import Foundation

struct Cart {
    
    static var shared = Cart()
    
    var items: [CartItem] = []
    
    var total: Double {
        var total: Double = 0
        
        for item in items {
            total += item.price
        }
        
        return total
    }
    
}

struct CartItem {
    
    var name: String
    var price: Double
    var ingredients: [Ingredient]?
    
}
