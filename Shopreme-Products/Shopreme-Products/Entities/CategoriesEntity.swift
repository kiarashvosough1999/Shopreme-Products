//
//  CategoriesEntity.swift
//  Shopeme-Products
//
//  Created by Kiarash Vosough on 7/7/23.
//

import Foundation

struct CategoriesEntity {
    let categories: [ProductCategoryEntity]
}

extension CategoriesEntity: Hashable {}
extension CategoriesEntity: Decodable {}
