//
//  Assets++Strings.swift
//  Shopreme-Products
//
//  Created by Kiarash Vosough on 7/10/23.
//

import Foundation

extension Assets {

    enum Strings: String {

        case stat
        case obst_und_gemüse

        var localized: String {
            NSLocalizedString(rawValue.replacingOccurrences(of: "_", with: " "), comment: "")
        }
    }
}

extension String {
    static func localized(_ key: Assets.Strings) -> String {
        key.localized
    }
}
