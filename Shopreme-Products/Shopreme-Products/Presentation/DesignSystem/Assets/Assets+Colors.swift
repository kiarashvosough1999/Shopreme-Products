//
//  Assets+Colors.swift
//  Shopreme-Products
//
//  Created by Kiarash Vosough on 7/10/23.
//

import UIKit.UIColor

extension Assets {

    enum Colors: String {
        case deep_black_1
        case deep_black_2
        case deep_black_3
        case deep_black_4
        case light_gray
        case background
        case white
    }
}

extension Assets.Colors {

    var color: UIColor? {
        UIColor(named: rawValue)
    }
}

extension UIColor {
    static func color(_ key: Assets.Colors) -> UIColor? {
        key.color
    }
}
