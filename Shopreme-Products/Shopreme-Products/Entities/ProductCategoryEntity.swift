//
//  ProductCategoryEntity.swift
//  Shopreme-Products
//
//  Created by Kiarash Vosough on 7/7/23.
//

import Foundation

struct ProductCategoryEntity {
    let title: String
    let products: [ProductEntity]
}

extension ProductCategoryEntity: Hashable {}
extension ProductCategoryEntity: Decodable {}
