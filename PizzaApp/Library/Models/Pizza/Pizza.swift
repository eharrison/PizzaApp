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
    
}

struct PizzaPayload: Codable {
    
    let pizzas: [Pizza]
    let basePrice: Double
    
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
