//
//  MLPaymentMethodsTest.swift
//  MLTestTests
//
//  Created by Robert Bevilacqua on 3/18/18.
//  Copyright © 2018 Robert Bevilacqua. All rights reserved.
//

import XCTest
@testable import MLTest

class MLPaymentMethodsTest: XCTestCase {
    
    var paymentControllerUnderTest: PaymentMethodsViewController!
    var dataMock: [PaymentMethods] = []
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        paymentControllerUnderTest = PaymentMethodsViewController(nibName: "PaymentMethodsViewController", bundle: nil)
        
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "ResponseRestApi", ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        
        do {
            self.dataMock = try JSONDecoder().decode([PaymentMethods].self, from: data!)
            
        } catch let jsonError {
            print(jsonError)
        }
        
    }
    
    func testValidCall() {
        
        let promise = expectation(description: "Status code: 200")
        paymentControllerUnderTest.viewModel.getPaymentMethods { (data, response, error) in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    // 2
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testCallComplete() {
        let promise = expectation(description: "Completion handler invoked")
        var statusCode: Int?
        var responseError: Error?
        
        paymentControllerUnderTest.viewModel.getPaymentMethods { (data, response, error) in
            
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
            
        }
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
    
    func testResultEqual() {
        let promise = expectation(description: "Equal result Mock")
        var dataApi: [PaymentMethods] = []
        
        paymentControllerUnderTest.viewModel.getPaymentMethods { (data, response, error) in
            guard let result = data else {
                XCTFail("Data is nil")
                return
            }
            
            dataApi = result
            promise.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNotNil(dataApi)
        XCTAssertNotEqual(dataApi, dataMock)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
}
