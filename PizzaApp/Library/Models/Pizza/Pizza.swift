//
//  Pizza.swift
//  PizzaApp
//
//  Created by Evandro Harrison Hoffmann on 10/3/18.
//  Copyright © 2018 It's Day Off. All rights reserved.
//

import Foundation

struct Pizza: Codable {
    
    let name: String
    var ingredients: [Int]
    let imageUrl: String?
    
    func price(forIngredients ingredientList: [Ingredient]) -> Double {
        var price: Double = 0
        
        for ingredientId in ingredients {
            for ingredient in ingredientList where ingredient.id == ingredientId {
                price += ingredient.price
            }
        }
        
        return price
    }
    
    func hasIngredient(withId id: Int) -> Bool {
        return ingredients.contains(id)
    }
    
    func ingredients(forIngredients ingredientList: [Ingredient]) -> [Ingredient] {
        var pizzaIngredients = [Ingredient]()
        
        for ingredientId in ingredients {
            for ingredient in ingredientList where ingredient.id == ingredientId {
                pizzaIngredients.append(ingredient)
            }
        }
        
        return pizzaIngredients
    }
    
    func ingredientNames(forIngredients ingredientList: [Ingredient]) -> String {
        var names = ""
        
        let pizzaIngredients = ingredients(forIngredients: ingredientList)
        
        for pizzaIngredient in pizzaIngredients {
            if names.count > 0 {
                names.append(", ")
            }
            
            names.append(pizzaIngredient.name)
        }
        
        return names
    }
    
}

struct PizzaPayload: Codable {
    
    let pizzas: [Pizza]
    let basePrice: Double
    
    func price(forPizza pizza: Pizza, withIngredients ingredientList: [Ingredient]) -> Double {
        return basePrice + pizza.price(forIngredients: ingredientList)
    }
    
}

// MARK: - Parsing

extension PizzaPayload {
    
    static func parse(_ data: Data) throws -> PizzaPayload {
        do {
            let decoded = try JSONDecoder().decode(PizzaPayload.self, from: data)
            return decoded
        } catch {
            throw AwesomeParserError.invalidPayload
        }
    }
    
}

// MARK: - API

extension Pizza {
    
    static let fetchURL = "https://api.myjson.com/bins/dokm7"
    
    static func list(_ completion: @escaping (PizzaPayload?) -> Void) {
        _ = AwesomeRequester.performRequest(fetchURL) { (data, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error while fetching ingredients: \(error.message)")
                    completion(nil)
                    return
                }
                
                guard let data = data else {
                    print("Data is nil")
                    completion(nil)
                    return
                }
                
                do {
                    let payload = try PizzaPayload.parse(data)
                    completion(payload)
                } catch {
                    print("Invalid payload")
                    completion(nil)
                }
            }
        }
    }
}
