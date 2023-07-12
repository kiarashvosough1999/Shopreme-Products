//
//  ProductDetailsViewModelTests.swift
//  Shopreme-ProductsTests
//
//  Created by Kiarash Vosough on 7/11/23.
//

import XCTest
import Factory
@testable import Shopreme_Products

final class ProductDetailsViewModelTests: XCTestCase, JSONLoader {

    private var sut: ProductDetailsViewModelProtocol!
    private var product: ProductEntity!
    private var imageData: Data!
    
    override func setUpWithError() throws {
        product = try loadAllProducts().first!
        imageData = MockData.data
        sut = ProductDetailsViewModel(product: product)

        Container.shared.loadImageDataRespository.register {
            LoadImageDataRespositoryMock(delayInSecond: 2, data: self.imageData)
        }
    }

    override func tearDownWithError() throws {
        sut = nil
        product = nil
        Container.shared.reset()
    }

    func testLoadingProduct() throws {

        let record = sut.didReceivedSnapshotPublisher
            .recordOnce()
            .waitAndCollectFirstRecord(timeout: 2)

        let context = ProductEntityToProductSnapShotMapper.Context(
            concyrrencyCode: "EUR",
            section: .main
        )

        XCTAssertNotNil(record)
        XCTAssertEqual(record!, ProductEntityToProductSnapShotMapper().map(product, context: context))
    }

    func testLoadingImage() throws {
        
        sut.fetchImage()
        
        let record = sut
            .imageLoadedPublisher
            .recordOnce()
            .waitAndCollectLastRecord(timeout: 3)
        
        XCTAssertNotNilNil(record)
        XCTAssertEqual(record!!, imageData)
    }

    func testClosePage() throws {
        
        sut.fetchImage()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.sut.closeButtonTapped()
        }
        
        let record = sut
            .closePagePublisher
            .recordOnce()
            .waitAndCollectLastRecord(timeout: 3)
        
        XCTAssertNotNil(record)
    }
}
