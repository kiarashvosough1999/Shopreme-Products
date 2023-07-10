//
//  CategorizedProductsRepositoryProtocol.swift
//  Shopreme-Products
//
//  Created by Kiarash Vosough on 7/11/23.
//

import Foundation

protocol CategorizedProductsRepositoryProtocol {
    func fetch() async throws -> [ProductCategoryEntity]
}
