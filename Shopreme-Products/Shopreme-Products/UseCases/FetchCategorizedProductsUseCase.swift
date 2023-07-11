//
//  FetchCategorizedProductsUseCase.swift
//  Shopeme-Products
//
//  Created by Kiarash Vosough on 7/10/23.
//

import Foundation
import Factory

// MARK: - Abstraction

protocol FetchCategorizedProductsUseCaseProtocol {
    func fetch() async throws -> [ProductCategoryEntity]
}

// MARK: - Implementation

final class FetchCategorizedProductsUseCase {
    
    @LazyInjected(\.categorizedProductsRepository) private var categorizedProductsRepository
}

extension FetchCategorizedProductsUseCase: FetchCategorizedProductsUseCaseProtocol {

    func fetch() async throws -> [ProductCategoryEntity] {
        try await categorizedProductsRepository.fetch()
    }
}
