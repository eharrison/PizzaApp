//
//  Drink.swift
//  PizzaApp
//
//  Created by Evandro Harrison Hoffmann on 10/3/18.
//  Copyright © 2018 It's Day Off. All rights reserved.
//

import Foundation

struct Drink: Codable {
    
    let id: Int
    let name: String
    let price: Double
    
}

// MARK: - Parsing

extension Drink {
    
    static func parseArray(_ data: Data) throws -> [Drink] {
        do {
            let decoded = try JSONDecoder().decode([Drink].self, from: data)
            return decoded
        } catch {
            throw AwesomeParserError.invalidPayload
        }
    }
    
}

// MARK: - API

extension Drink {
    
    static let fetchURL = "https://api.myjson.com/bins/150da7"
    
    static func list(_ completion: @escaping ([Drink]) -> Void) {
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
                    let drinks = try Drink.parseArray(data)
                    completion(drinks)
                } catch {
                    print("Invalid payload")
                    completion([])
                }
            }
        }
    }
}
