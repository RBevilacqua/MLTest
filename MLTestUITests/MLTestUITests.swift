//
//  MLTestUITests.swift
//  MLTestUITests
//
//  Created by Robert Bevilacqua on 3/13/18.
//  Copyright © 2018 Robert Bevilacqua. All rights reserved.
//

import XCTest

class MLTestUITests: XCTestCase {
    
    var app: XCUIApplication!
        
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testApp() -> Void {
        
        let app = XCUIApplication()
        let textField = app.otherElements.containing(.navigationBar, identifier:"MLTest.AmountView").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textField).element
        textField.tap()
        textField.typeText("3000")
        
        let toolbarDoneButtonButton = app.toolbars.buttons["Toolbar Done Button"]
        toolbarDoneButtonButton.tap()
        textField.tap()
        toolbarDoneButtonButton.tap()
        app.buttons["Pagar"].tap()
        app.collectionViews.children(matching: .cell).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0).tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Citi"]/*[[".cells.staticTexts[\"Citi\"]",".staticTexts[\"Citi\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["12 cuotas de $ 355,28 ($ 4.263,30)"]/*[[".cells.staticTexts[\"12 cuotas de $ 355,28 ($ 4.263,30)\"]",".staticTexts[\"12 cuotas de $ 355,28 ($ 4.263,30)\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Aceptar"].tap()
        
    }
    
}
