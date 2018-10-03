//
//  PizzaTests.swift
//  PizzaAppTests
//
//  Created by Evandro Harrison Hoffmann on 10/3/18.
//  Copyright © 2018 It's Day Off. All rights reserved.
//

import XCTest
@testable import PizzaApp

class PizzaTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testURLCorrect() {
        XCTAssertEqual(Pizza.fetchURL, "https://api.myjson.com/bins/dokm7")
    }
    
    func testParsingArraySuccessPayload() {
        guard let data = MockJSONLoader.loadJSONData(file: "pizzas", usingClass: self) else {
            XCTFail("a json FILE is needed in order to proceed with the test")
            return
        }
        
        XCTAssertNoThrow(try PizzaPayload.parse(data))
        XCTAssertNotNil(try PizzaPayload.parse(data))
        XCTAssertEqual(try PizzaPayload.parse(data).pizzas.count, 10)
        XCTAssertEqual(try PizzaPayload.parse(data).basePrice, 4)
    }
    
    func testParsingArrayInvalidPayload() {
        XCTAssertThrowsError(try PizzaPayload.parse(Data()))
        XCTAssertThrowsError(try PizzaPayload.parse(Data()), "") { (error) in
            XCTAssertNotNil(error as? AwesomeParserError, "\(error) is not \(AwesomeParserError.self)")
            XCTAssertEqual(error as? AwesomeParserError, AwesomeParserError.invalidPayload)
        }
    }

}
