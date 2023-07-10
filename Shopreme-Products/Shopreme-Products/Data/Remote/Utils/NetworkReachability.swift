//
//  NetworkReachability.swift
//  Shopreme-Products
//
//  Created by Kiarash Vosough on 7/7/23.
//

import Foundation
import Network

final class NetworkReachability {

    private let pathMonitor: NWPathMonitor

    init() {
        pathMonitor = NWPathMonitor()
    }

    func isNetworkAvailable() async -> Bool {
        await withCheckedContinuation { continuation in
            pathMonitor.pathUpdateHandler = { path in
                switch path.status {
                case .requiresConnection, .unsatisfied:
                    continuation.resume(returning: false)
                case .satisfied:
                    continuation.resume(returning: true)
                @unknown default:
                    continuation.resume(returning: false)
                }
            }
            pathMonitor.start(queue: .global(qos: .background))
        }
    }
}
