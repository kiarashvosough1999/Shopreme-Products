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
    
    init(delayInSecond: UInt64 = 0, productCategory: [ProductCategoryEntity] = [], error: Error? = nil) {
        self.delayInSecond = delayInSecond
        self.productCategory = productCategory
        self.error = error
    }
}

extension FetchCategorizedProductsUseCaseMock: FetchCategorizedProductsUseCaseProtocol {
    func fetch() async throws -> [ProductCategoryEntity] {
        try await Task.sleep(nanoseconds: UInt64(delayInSecond * NSEC_PER_SEC))
        if let error { throw error }
        return productCategory
    }
}
