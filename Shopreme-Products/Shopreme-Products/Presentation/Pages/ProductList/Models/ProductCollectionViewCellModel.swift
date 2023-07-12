//
//  ProductCollectionViewCellModel.swift
//  Shopreme-Products
//
//  Created by Kiarash Vosough on 7/10/23.
//

import Foundation

struct ProductCollectionViewCellModel {
    let imageURL: URL
    let title: String
    let price: String
    let strikePrefix: String
    let strikePrice: String
}

extension ProductCollectionViewCellModel: Hashable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.imageURL == rhs.imageURL &&
        lhs.title == rhs.title &&
        lhs.price == rhs.price &&
        lhs.strikePrice == rhs.strikePrice
    }
}

extension ProductCollectionViewCellModel: Identifiable {
    var id: Int { hashValue }
}
