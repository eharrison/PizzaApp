//
//  Cart.swift
//  PizzaApp
//
//  Created by Evandro Harrison Hoffmann on 10/4/18.
//  Copyright © 2018 It's Day Off. All rights reserved.
//

import Foundation

class Cart {
    
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
    
    func add(itemWithName name: String, price: Double, object: Any? = nil, ingredients: [Ingredient]? = nil) {
        items.append(CartItem(id: Int(Date.timeIntervalSinceReferenceDate), name: name, price: price, object: object, ingredients: ingredients))
    }
    
    func edit(item: CartItem, name: String, price: Double, object: Any? = nil, ingredients: [Ingredient]? = nil) {
        for (index, editingItem) in items.enumerated() where editingItem.id == item.id {
            items[index] = CartItem(id: item.id, name: name, price: price, object: object, ingredients: ingredients)
        }
    }
    
    func remove(itemWithPosition position: Int) {
        guard position < items.count, position >= 0 else {
            return
        }
        
        items.remove(at: position)
    }
}

struct CartItem {
    
    var id: Int
    var name: String
    var price: Double
    var object: Any?
    var ingredients: [Ingredient]?
    
    func hasIngredient(withId id: Int) -> Bool {
        guard let ingredients = ingredients else {
            return false
        }
        
        for ingredient in ingredients where ingredient.id == id {
            return true
        }
        
        return false
    }
}
