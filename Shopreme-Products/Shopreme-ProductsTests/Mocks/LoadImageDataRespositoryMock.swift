//
//  LoadImageDataRespositoryMock.swift
//  Shopreme-ProductsTests
//
//  Created by Kiarash Vosough on 7/11/23.
//

import Foundation
@testable import Shopreme_Products

final class LoadImageDataRespositoryMock: Mock {

    enum Action: Equatable {
        case loadimageData(URL)
    }
    
    var delayInSecond: UInt64 = 0
    var url: URL?
    var data: Data?
    var error: Error?
    var actions: MockActions<Action>
    
    init(actions: MockActions<Action> = .init(), delayInSecond: UInt64 = 0, url: URL? = nil, data: Data? = nil, error: Error? = nil) {
        self.actions = actions
        self.delayInSecond = delayInSecond
        self.url = url
        self.data = data
        self.error = error
    }
}

extension LoadImageDataRespositoryMock: LoadImageDataRespositoryProtocol {

    func loadimageData(_ url: URL) async throws -> Data {
        try await Task.sleep(nanoseconds: UInt64(delayInSecond * NSEC_PER_SEC))
        if let error { throw error }
        self.url = url
        actions.register(.loadimageData(url))
        return data!
    }
}
