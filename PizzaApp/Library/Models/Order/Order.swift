//
//  Order.swift
//  PizzaApp
//
//  Created by Evandro Harrison Hoffmann on 10/3/18.
//  Copyright © 2018 It's Day Off. All rights reserved.
//

import Foundation

struct Order: Codable {
    
    var pizzas: [Pizza]
    var drinks: [Drink]
    
}

// MARK: - Parsing

extension Order {
    
    func encode() throws -> Data? {
        do {
            let encoded = try JSONEncoder().encode(self)
            return encoded
        } catch {
            throw AwesomeParserError.invalidPayload
        }
    }
    
    static func parse(_ data: Data) throws -> Order {
        do {
            let decoded = try JSONDecoder().decode(Order.self, from: data)
            return decoded
        } catch {
            throw AwesomeParserError.invalidPayload
        }
    }
    
}

// MARK: - API

extension Order {
    
    static let postURL = "http://posttestserver.com/post.php"
    
    func post(_ completion: @escaping (_ success: Bool) -> Void) {
        do {
            let data = try encode()
            
            _ = AwesomeRequester.performRequest(Order.postURL, method: .POST, bodyData: data) { (data, error) in
                DispatchQueue.main.async {
                    if let error = error {
                        print("Error while fetching ingredients: \(error.message)")
                        completion(false)
                        return
                    }
                    
                    guard let data = data else {
                        print("Data is nil")
                        completion(false)
                        return
                    }
                    
                    /*do {
                     let ingredients = try Ingredient.parseArray(data)
                     completion(true)
                     } catch {
                     print("Invalid payload")
                     completion(false)
                     }*/
                }
            }
        } catch {
            print("Failed to encode")
            completion(false)
            return
        }
        
        
    }
}
