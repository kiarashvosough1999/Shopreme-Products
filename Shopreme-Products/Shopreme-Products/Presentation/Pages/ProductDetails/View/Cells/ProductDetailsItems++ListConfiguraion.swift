//
//  ProductDetailsItems++ListConfiguraion.swift
//  Shopreme-Products
//
//  Created by Kiarash Vosough on 7/11/23.
//

import UIKit

extension ProductDetailsItems.Title: ListContentConfiguration {

    func update(configuration: inout UIListContentConfiguration) {
        var att = AttributedString(stringLiteral: title)
        att[AttributeScopes.UIKitAttributes.ForegroundColorAttribute.self] = .color(.deep_black_1)
        att[AttributeScopes.UIKitAttributes.FontAttribute.self] = Assets.Fonts.Black.title
        configuration.attributedText = NSAttributedString(att)
        configuration.textProperties.numberOfLines = 0
        configuration.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 30, leading: 0, bottom: 32, trailing: 0)
    }
}

extension ProductDetailsItems.Price: ListContentConfiguration {

    func update(configuration: inout UIListContentConfiguration) {
        var att = AttributedString(stringLiteral: price)
        att[AttributeScopes.UIKitAttributes.ForegroundColorAttribute.self] = .color(.deep_black_2)
        att[AttributeScopes.UIKitAttributes.FontAttribute.self] = Assets.Fonts.Black.title2
        configuration.attributedText = NSAttributedString(att)
    }
}
extension ProductDetailsItems.Description: ListContentConfiguration {

    func update(configuration: inout UIListContentConfiguration) {
        var att = AttributedString(stringLiteral: description)
        att[AttributeScopes.UIKitAttributes.ForegroundColorAttribute.self] = .color(.deep_black_4)
        att[AttributeScopes.UIKitAttributes.FontAttribute.self] = Assets.Fonts.Regular.body
        configuration.textProperties.numberOfLines = 0
        configuration.attributedText = NSAttributedString(att)
    }
}
