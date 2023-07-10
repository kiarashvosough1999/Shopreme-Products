//
//  StrikeLabel.swift
//  Shopreme-Products
//
//  Created by Kiarash Vosough on 7/10/23.
//

import UIKit

final class StrikeLabel: UILabel {

    init(beforeStrike: String = "", strike: String) {
        super.init(frame: .zero)
        setText(beforeStrike: beforeStrike, strike: strike)
    }

    init() {
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setText(beforeStrike: String = "", strike: String) {
        numberOfLines = 1
        var beforeStrike = AttributedString(stringLiteral: beforeStrike)
        beforeStrike[AttributeScopes.UIKitAttributes.ForegroundColorAttribute.self] = Assets.Colors.light_gray.color
        beforeStrike[AttributeScopes.UIKitAttributes.FontAttribute.self] = Assets.Fonts.Medium.caption
        
        var string = AttributedString(stringLiteral: strike)
        string[AttributeScopes.UIKitAttributes.StrikethroughColorAttribute.self] = Assets.Colors.light_gray.color
        string[AttributeScopes.UIKitAttributes.StrikethroughStyleAttribute.self] = .single
        string[AttributeScopes.UIKitAttributes.ForegroundColorAttribute.self] = Assets.Colors.light_gray.color
        string[AttributeScopes.UIKitAttributes.FontAttribute.self] = Assets.Fonts.Medium.caption
        
        beforeStrike.append(string)
        self.attributedText = NSAttributedString(beforeStrike)
    }
}
