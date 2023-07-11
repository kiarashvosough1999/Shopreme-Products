//
//  Throttler.swift
//  Shopreme-Products
//
//  Created by Kiarash Vosough on 7/11/23.
//

import Foundation

final class Throttler {
    private let delay: TimeInterval
    private var workItem: DispatchWorkItem?
    private var lastAttempt: Date?

    init(delay: TimeInterval) {
        self.delay = delay
        self.lastAttempt = .init(timeIntervalSinceNow: delay + 1)
    }

    func go(queue: DispatchQueue = .main, _ action: @escaping () -> Void) {
        if let lastAttempt, lastAttempt.timeIntervalSinceNow >= delay {
            workItem = DispatchWorkItem(block: action)
            queue.asyncAfter(deadline: .now(), execute: workItem!)
        } else {
            workItem?.cancel()
            workItem = DispatchWorkItem(block: action)
            queue.asyncAfter(deadline: .now() + delay, execute: workItem!)
        }
        lastAttempt = .now
    }
}
