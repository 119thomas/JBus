//
//  JBusTests.swift
//  JBusTests
//
//  Created by William Thomas on 2/7/19.
//  Copyright © 2019 William Thomas. All rights reserved.
//

import XCTest
@testable import JBus

class JBusTests: XCTestCase {
    let pinky = brains()

    func testParseShuttleNumbers() {
        print("TESTING")
        pinky.setRouteTags()
        pinky.configRoutes()
        pinky.printShuttles()
        print("DONE TESTING")
    }
}
