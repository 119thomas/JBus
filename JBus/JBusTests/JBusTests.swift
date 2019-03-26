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
        
        let queue = DispatchQueue(label: "Q")
        queue.sync {
            pinky.execute()
        }
        
        let universityview = pinky.getShuttles()[15]
        let stops = pinky.getStops(shuttle: universityview)
        let predictions = pinky.requestPredictions(stop: stops[0])
        print(predictions)
        print("DONE TESTING")
    }
}
