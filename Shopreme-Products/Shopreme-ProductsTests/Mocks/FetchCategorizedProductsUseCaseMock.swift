//
//  FetchCategorizedProductsUseCaseMock.swift
//  Shopreme-ProductsTests
//
//  Created by Kiarash Vosough on 7/11/23.
//

import Foundation
@testable import Shopreme_Products

final class FetchCategorizedProductsUseCaseMock {
    var delayInSecond: UInt64 = 0
    var productCategory: [ProductCategoryEntity] = []
    var error: Error?
}

extension FetchCategorizedProductsUseCaseMock: FetchCategorizedProductsUseCaseProtocol {
    func fetch() async throws -> [Shopreme_Products.ProductCategoryEntity] {
        try await Task.sleep(nanoseconds: UInt64(delayInSecond * 1_000_000_000))
        if let error { throw error }
        return productCategory
    }
}
