//
//  NetworkServices+CategorizedProductsRepositoryProtocol.swift
//  Shopreme-Products
//
//  Created by Kiarash Vosough on 7/7/23.
//

import Foundation

extension NetworkServices: CategorizedProductsRepositoryProtocol {

    func fetch() async throws -> [ProductCategoryEntity] {
        guard await reachability.isNetworkAvailable() else {
            throw NonDomainError.networkUnavailable
        }
        let result = try await session.data(for: Request())
        guard result.statusCode == .OK else { throw NetworkError.requestFailed }
        return try result.decode(to: CategoriesEntity.self).categories
    }
}

// MARK: - Request

fileprivate struct Request {}

extension Request: API {

    var gateway: GateWays { .base }
    var method: HTTPMethod { .get }
    var route: String { "products_categories.json" }
}
