//
//  LoadImageDataUseCaseMock.swift
//  Shopreme-ProductsTests
//
//  Created by Kiarash Vosough on 7/11/23.
//

import Foundation
@testable import Shopreme_Products

final class LoadImageDataUseCaseMock {
    var delayInSecond: UInt64
    var url: URL?
    var data: Data?
    var error: Error?

    init(delayInSecond: UInt64 = 0, data: Data? = nil, error: Error? = nil) {
        self.delayInSecond = delayInSecond
        self.data = data
        self.error = error
    }
}

extension LoadImageDataUseCaseMock: LoadImageDataUseCaseProtocol {

    func loadimageData(_ url: URL) async throws -> Data {
        try await Task.sleep(nanoseconds: UInt64(delayInSecond * NSEC_PER_SEC))
        if let error { throw error }
        self.url = url
        return data!
    }
}
