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
    
    func processOrder(_ completion: @escaping (_ success: Bool) -> Void) {
        var pizzas = [Pizza]()
        var drinks = [Drink]()
        
        for item in items {
            if let pizza = item.object as? Pizza {
                pizzas.append(pizza)
            } else if let drink = item.object as? Drink {
                drinks.append(drink)
            }
        }
        
        let order = Order(pizzas: pizzas, drinks: drinks)
        order.post(completion)
    }
    
}

struct CartItem {
    
    var name: String
    var price: Double
    var object: Any?
    var ingredients: [Ingredient]?
    
}
