//
//  IngredientTests.swift
//  PizzaAppTests
//
//  Created by Evandro Harrison Hoffmann on 10/3/18.
//  Copyright © 2018 It's Day Off. All rights reserved.
//

import XCTest
@testable import PizzaApp

class IngredientTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testURLCorrect() {
        XCTAssertEqual(Ingredient.fetchURL, "https://api.myjson.com/bins/ozt3z")
    }

    func testParsingArraySuccessPayload() {
        guard let data = MockJSONLoader.loadJSONData(file: "ingredients", usingClass: self) else {
            XCTFail("a json FILE is needed in order to proceed with the test")
            return
        }
        
        XCTAssertNoThrow(try Ingredient.parseArray(data))
        XCTAssertNotNil(try Ingredient.parseArray(data))
        XCTAssertEqual(try Ingredient.parseArray(data).count, 10)
        XCTAssertEqual(try Ingredient.parseArray(data).first?.id, 1)
    }
    
    func testParsingArrayInvalidPayload() {
        XCTAssertThrowsError(try Ingredient.parseArray(Data()))
        XCTAssertThrowsError(try Ingredient.parseArray(Data()), "") { (error) in
            XCTAssertNotNil(error as? AwesomeParserError, "\(error) is not \(AwesomeParserError.self)")
            XCTAssertEqual(error as? AwesomeParserError, AwesomeParserError.invalidPayload)
        }
    }
    

}
