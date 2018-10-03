//
//  DrinkTests.swift
//  PizzaAppTests
//
//  Created by Evandro Harrison Hoffmann on 10/3/18.
//  Copyright © 2018 It's Day Off. All rights reserved.
//

import XCTest
@testable import PizzaApp

class DrinkTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testURLCorrect() {
        XCTAssertEqual(Drink.fetchURL, "https://api.myjson.com/bins/150da7")
    }
    
    func testParsingArraySuccessPayload() {
        guard let data = MockJSONLoader.loadJSONData(file: "drinks", usingClass: self) else {
            XCTFail("a json FILE is needed in order to proceed with the test")
            return
        }
        
        XCTAssertNoThrow(try Drink.parseArray(data))
        XCTAssertNotNil(try Drink.parseArray(data))
        XCTAssertEqual(try Drink.parseArray(data).count, 5)
        XCTAssertEqual(try Drink.parseArray(data).first?.id, 1)
    }
    
    func testParsingArrayInvalidPayload() {
        XCTAssertThrowsError(try Drink.parseArray(Data()))
        XCTAssertThrowsError(try Drink.parseArray(Data()), "") { (error) in
            XCTAssertNotNil(error as? AwesomeParserError, "\(error) is not \(AwesomeParserError.self)")
            XCTAssertEqual(error as? AwesomeParserError, AwesomeParserError.invalidPayload)
        }
    }
}
