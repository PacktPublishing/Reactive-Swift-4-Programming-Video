//
//  rxswiftcourseTests.swift
//  rxswiftcourseTests
//
//  Created by James Saeed on 28/01/2018.
//  Copyright © 2018 James Saeed. All rights reserved.
//

import XCTest
@testable import rxswiftcourse

class rxswiftcourseTests: XCTestCase {
    
    var vc: ViewController!
    
    override func setUp() {
        super.setUp()
        
        vc = ViewController()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        assert(vc.movies.count == 0)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
