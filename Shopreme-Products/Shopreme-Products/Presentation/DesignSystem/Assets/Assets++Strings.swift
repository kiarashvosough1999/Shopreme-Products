//
//  Assets++Strings.swift
//  Shopeme-Products
//
//  Created by Kiarash Vosough on 7/10/23.
//

import Foundation

extension Assets {

    enum Strings: String {

        case stat

        var localized: String {
            NSLocalizedString(rawValue, comment: "")
        }
    }
}

extension String {
    static func localized(_ key: Assets.Strings) -> String {
        key.localized
    }
}
