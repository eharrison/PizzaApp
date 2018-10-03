//
//  OrderTests.swift
//  PizzaAppTests
//
//  Created by Evandro Harrison Hoffmann on 10/3/18.
//  Copyright © 2018 It's Day Off. All rights reserved.
//

import XCTest
@testable import PizzaApp

class OrderTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testURLCorrect() {
        XCTAssertEqual(Order.postURL, "http://posttestserver.com/post.php")
    }
    
    func testEncodingDecoding() {
        let order = Order(pizzas: [Pizza(name: "Napolitana", ingredients: [1], imageUrl: nil)], drinks: [Drink(id: 1, name: "Coke", price: 12)])
        
        do {
            let data = try order.encode()
            XCTAssertNotNil(data)
            XCTAssertEqual(try Order.parse(data ?? Data()).pizzas.count, 1)
            XCTAssertEqual(try Order.parse(data ?? Data()).drinks.count, 1)
        }
        catch {
            XCTFail()
        }
        
    }
    
}
