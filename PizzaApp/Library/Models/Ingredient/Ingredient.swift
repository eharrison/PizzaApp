//
//  Ingredient.swift
//  PizzaApp
//
//  Created by Evandro Harrison Hoffmann on 10/3/18.
//  Copyright © 2018 It's Day Off. All rights reserved.
//

import Foundation

struct Ingredient: Codable {
    
    let id: Int
    let name: String
    let price: Double
    
}

// MARK: - Parsing

extension Ingredient {
    
    static func parseArray(_ data: Data) throws -> [Ingredient] {
        do {
            let decoded = try JSONDecoder().decode([Ingredient].self, from: data)
            return decoded
        } catch {
            throw AwesomeParserError.invalidPayload
        }
    }
    
}

// MARK: - API

extension Ingredient {
    
    static let fetchURL = "https://api.myjson.com/bins/ozt3z"
    
    static func list(_ completion: @escaping ([Ingredient]) -> Void) {
        _ = AwesomeRequester.performRequest(fetchURL) { (data, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error while fetching ingredients: \(error.message)")
                    completion([])
                    return
                }
                
                guard let data = data else {
                    print("Data is nil")
                    completion([])
                    return
                }
                
                do {
                    let ingredients = try Ingredient.parseArray(data)
                    completion(ingredients)
                } catch {
                    print("Invalid payload")
                    completion([])
                }
            }
        }
    }
}
