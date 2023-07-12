//
//  Throttler.swift
//  Shopreme-Products
//
//  Created by Kiarash Vosough on 7/11/23.
//

import Foundation

final class Throttler {
    private let delay: TimeInterval
    private var lastAttempt: Date?

    init(delay: TimeInterval) {
        self.delay = delay
        self.lastAttempt = .init(timeIntervalSinceNow: delay + 1)
    }

    func canGo() -> Bool {
        defer {
            lastAttempt = .now
        }
        if let lastAttempt, lastAttempt.timeIntervalSinceNow >= delay {
            return true
        } else {
            return false
        }
    }
}
