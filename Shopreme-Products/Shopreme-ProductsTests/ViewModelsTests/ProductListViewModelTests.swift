//
//  ProductListViewModelTests.swift
//  Shopreme-ProductsTests
//
//  Created by Kiarash Vosough on 7/11/23.
//

import XCTest
import Factory
@testable import Shopreme_Products

final class ProductListViewModelTests: XCTestCase, JSONLoader {

    private var sut: ProductListViewModelProtocol!

    override func setUpWithError() throws {
        sut = ProductListViewModel()
        let imageData = MockData.data
        let delay: UInt64 = 2

        Container.shared.loadImageDataRespository.register {
            LoadImageDataRespositoryMock(delayInSecond: delay, data: imageData)
        }
    }

    override func tearDownWithError() throws {
        sut = nil
        Container.shared.reset()
    }

    func testShowProductDetailsSubject() async throws {
        let mockProducts = try loadCategorizedProducts()
        let delayInSecond: UInt64 = 2
        let indexPath = IndexPath(row: 0, section: 0)

        Container.shared.categorizedProductsRepository.register {
            CategorizedProductsRepositoryMock(
                delayInSecond: delayInSecond,
                productCategory: mockProducts.categories
            )
        }

        await sut.fetchProducts()
        sut.didSelectedItem(at: indexPath)
        
        let record = sut
            .showProductDetailsPublisher
            .recordOnce()
            .waitAndCollectFirstRecord(timeout: 1)

        XCTAssertNotNilNil(record)
    }

    func testShouldStartActivity() async throws {
        let delayInSecond: UInt64 = 2

        Container.shared.categorizedProductsRepository.register {
            CategorizedProductsRepositoryMock(delayInSecond: delayInSecond)
        }

        Task {
            await sut.fetchProducts()
        }
        
        let record = sut
            .shouldStartActivity
            .record(numberOfRecords: 2)
            .waitAndCollectLastRecord(timeout: 3)

        XCTAssertNotNilNil(record)
    }

    func testShouldStartActivityAndStopOnError() async throws {
        let delayInSecond: UInt64 = 2
        let domain = "test"
        let code = -123
        let error = NSError(domain: domain, code: code)

        Container.shared.categorizedProductsRepository.register {
            CategorizedProductsRepositoryMock(delayInSecond: delayInSecond, error: error)
        }

        Task {
            await sut.fetchProducts()
        }
        
        let records = sut
            .shouldStartActivity
            .record(numberOfRecords: 2)
            .waitAndCollectRecords(timeout: 3)

        XCTAssertEqual(records.count, 2)
        XCTAssertNotNil(records.first)
        XCTAssertNotNil(records.last)
    }

    func testShouldStartRetryPublisher() async throws {
        let delayInSecond: UInt64 = 2

        Container.shared.categorizedProductsRepository.register {
            CategorizedProductsRepositoryMock(delayInSecond: delayInSecond)
        }

        await sut.fetchProducts()
        
        let record = sut
            .shouldStartRetryPublisher
            .recordOnce()
            .waitAndCollectFirstRecord(timeout: 2)

        XCTAssertNilNil(record)
    }

    func testShouldStartRetryPublisherAndStartOnErrorAgain() async throws {
        let delayInSecond: UInt64 = 2
        let domain = "test"
        let code = -123
        let error = NSError(domain: domain, code: code)

        Container.shared.categorizedProductsRepository.register {
            CategorizedProductsRepositoryMock(delayInSecond: delayInSecond, error: error)
        }

        await sut.fetchProducts()
        
        let records = sut
            .shouldStartRetryPublisher
            .recordOnce()
            .waitAndCollectLastRecord(timeout: 3)

        XCTAssertNotNilNil(records)
    }

    func testFetchProductsSuccessfull() async throws {
        let mockProducts = try loadCategorizedProducts()
        let delayInSecond: UInt64 = 2
        
        Container.shared.categorizedProductsRepository.register {
            CategorizedProductsRepositoryMock(delayInSecond: delayInSecond, productCategory: mockProducts.categories)
        }
        
        Task {
            await sut.fetchProducts()
        }

        let records = sut
            .didReceivedSnapshot
            .record(numberOfRecords: 2)
            .waitAndCollectRecords(timeout: 3)
            .map(\.value)
            .compactMap { $0 }
            .flatMap { $0 }

        let mapper = ProductCategoryEntityToProductCategorySnapShotMapper()
        let context = ProductCategoryEntityToProductCategorySnapShotMapper.Context(currencyCode: "EUR")
        
        XCTAssertEqual(records.count, 2)
        XCTAssertEqual(records.map(\.section.title), mockProducts.categories.map(\.title))
        XCTAssertEqual(
            records,
            mapper.map(mockProducts.categories, context: context)
        )
    }
}
