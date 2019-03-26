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
    
    func testParseShuttleNumbers() {
        let pinky = brains()
        
        print("TESTING")
        let universityview = pinky.getShuttles()[15]
        let stops = pinky.getStops(shuttle: universityview)
        let predictions = pinky.requestPredictions(stop: stops[0])
        print(predictions)
        print("DONE TESTING")
    }
}
