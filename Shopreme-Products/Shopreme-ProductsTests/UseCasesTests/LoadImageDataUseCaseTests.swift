//
//  LoadImageDataUseCaseTests.swift
//  Shopreme-ProductsTests
//
//  Created by Kiarash Vosough on 7/11/23.
//

@testable import Shopreme_Products
import XCTest
import Factory

final class LoadImageDataUseCaseTests: XCTestCase, JSONLoader, TimeMeasurer {
    
    private var sut: LoadImageDataUseCaseProtocol!
    
    override func setUpWithError() throws {
        sut = LoadImageDataUseCase()
    }

    override func tearDownWithError() throws {
        sut = nil
        Container.shared.reset()
    }

    func testReceivingImageDataSuccessfully() async throws {
        let data = Data(repeating: 12, count: 12)
        let url = MockURL.urls.first!
        let delayInSecond: UInt64 = 2
        let loadImageDataRespositoryMockActions = MockActions<LoadImageDataRespositoryMock.Action>(expected: [.loadimageData(url)])
        
        Container.shared.loadImageDataRespository.register {
            LoadImageDataRespositoryMock(actions: loadImageDataRespositoryMockActions, delayInSecond: delayInSecond, data: data)
        }

        try await measureExecution(expectedTime: delayInSecond) {
            let imageData = try await sut.loadimageData(url)
            
            XCTAssertEqual(data, imageData)
            loadImageDataRespositoryMockActions.verify()
        }
    }

    func testReceivingImageDataFailed() async throws {
        let data = Data(repeating: 12, count: 12)
        let url = MockURL.urls.first!
        let domain = "test"
        let code = -123
        let delayInSecond: UInt64 = 2
        let error = NSError(domain: domain, code: code)
        
        Container.shared.loadImageDataRespository.register {
            LoadImageDataRespositoryMock(delayInSecond: delayInSecond, data: data, error: error)
        }

        try await measureExecution(expectedTime: delayInSecond) {
            await XCTAssertThrowsError(try await sut.loadimageData(url)) { error in
                let error = error as NSError
                XCTAssertEqual(error.domain, domain)
                XCTAssertEqual(error.code, code)
            }
        }
    }

}
