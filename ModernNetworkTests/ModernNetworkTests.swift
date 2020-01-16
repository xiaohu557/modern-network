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
    let dataProvider = GithubDataProvider()

    override func setUp() {
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchHottestRepos() {
        let e = expectation(description: "Load data from network")
        e.expectedFulfillmentCount = 2

        dataProvider.hottestRepos.bind { value in
            if value.count == 2 {
                e.fulfill()
            }
        }
        dataProvider.error.bind { error in
            if error == nil {
                e.fulfill()
            }
        }
        dataProvider.fetchData()

        wait(for: [e], timeout: 15)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
