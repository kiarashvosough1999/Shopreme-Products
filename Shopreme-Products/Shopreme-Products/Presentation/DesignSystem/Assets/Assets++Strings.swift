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
        case produckte_werden_geladen = "produckte werden geladen..."
        case wiederholen
        case die_internetverbindung_scheint_offline_zu_sein = "die internetverbindung scheint offline zu sein."

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
