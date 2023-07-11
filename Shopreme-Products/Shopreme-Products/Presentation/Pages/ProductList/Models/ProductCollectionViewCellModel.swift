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

extension ProductCollectionViewCellModel: Hashable {}
extension ProductCollectionViewCellModel: Identifiable {
    var id: Int { hashValue }
}
