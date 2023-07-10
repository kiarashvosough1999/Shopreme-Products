//
//  GateWays.swift
//  Shopreme-Products
//
//  Created by Kiarash Vosough on 7/7/23.
//

import Foundation

internal enum GateWays: String {
    case base = "https://shopreme.com/jobinterview/data"
}

extension GateWays {
    func get() -> URL? {
        return URL(string: rawValue)
    }
}
