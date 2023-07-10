//
//  ProductCategoryEntity.swift
//  Shopeme-Products
//
//  Created by Kiarash Vosough on 7/7/23.
//

import Foundation

struct ProductCategoryEntity: Identifiable {
    let id: UUID
    let title: String
    let products: [ProductEntity]
}

extension ProductCategoryEntity: Hashable {}
extension ProductCategoryEntity: Decodable {}
