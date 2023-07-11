//
//  TimeMeasurer.swift
//  Shopreme-ProductsTests
//
//  Created by Kiarash Vosough on 7/11/23.
//

import XCTest

protocol TimeMeasurer {}

extension TimeMeasurer {

    func measureExecution(expectedTime: UInt64, _ block: () async throws -> Void) async throws {
        let duration = try await ContinuousClock().measure {
            try await block()
        }
        XCTAssertEqual(UInt64(duration.components.seconds), expectedTime)
    }
}
