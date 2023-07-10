//
//  FetchCategorizedProductsUseCaseTests.swift
//  Shopreme-ProductsTests
//
//  Created by Kiarash Vosough on 7/11/23.
//

@testable import Shopreme_Products
import XCTest
import Factory

final class FetchCategorizedProductsUseCaseTests: XCTestCase, JSONLoader, TimeMeasurer {

    private var sut: FetchCategorizedProductsUseCaseProtocol!
    
    override func setUpWithError() throws {
        sut = FetchCategorizedProductsUseCase()
    }

    override func tearDownWithError() throws {
        sut = nil
        Container.shared.reset()
    }

    func testFetchProductsSuccessed() async throws {
        let mockProducts = try loadCategorizedProducts()
        let delayInSecond: UInt64 = 2
        
        Container.shared.categorizedProductsRepository.register {
            CategorizedProductsRepositoryMock(delayInSecond: delayInSecond, productCategory: mockProducts.categories)
        }

        try await measureExecution(expectedTime: delayInSecond) {
            let products = try await sut.fetch()
            
            XCTAssertEqual(products.count, mockProducts.categories.count)
            XCTAssertEqual(products, mockProducts.categories)
        }
    }
    
    func testFetchProductsFailed() async throws {
        let domain = "test"
        let code = -123
        let delayInSecond: UInt64 = 2
        let error = NSError(domain: domain, code: code)
        
        Container.shared.categorizedProductsRepository.register {
            CategorizedProductsRepositoryMock(delayInSecond: delayInSecond, error: error)
        }

        try await measureExecution(expectedTime: delayInSecond) {
            await XCTAssertThrowsError(try await sut.fetch()) { error in
                let error = error as NSError
                XCTAssertEqual(error.domain, domain)
                XCTAssertEqual(error.code, code)
            }
        }
    }

}
