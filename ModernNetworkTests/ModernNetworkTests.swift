//
//  ModernNetworkTests.swift
//  ModernNetworkTests
//
//  Created by Xi Chen on 09.01.20.
//  Copyright © 2020 Xi Chen. All rights reserved.
//

import XCTest
@testable import ModernNetwork

class ModernNetworkTests: XCTestCase {
    let githubService = ServiceProvider<GitHubService>()

    override func setUp() {
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
