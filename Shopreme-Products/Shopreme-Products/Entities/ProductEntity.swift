//
//  ProductModel.swift
//  Shopeme-Products
//
//  Created by Kiarash Vosough on 7/7/23.
//

import Foundation

struct ProductEntity: Identifiable {
    let id: UUID
    let title: String
    let imageURL: URL
    let price: Double
    let strikePrice: Double?
    let description: String
}

extension ProductEntity: Hashable {}
extension ProductEntity: Decodable {}
