//
//  LoadImageDataUseCase.swift
//  Shopeme-Products
//
//  Created by Kiarash Vosough on 7/10/23.
//

import Foundation
import Factory

// MARK: - Asbtraction

protocol LoadImageDataUseCaseProtocol {
    func loadimageData(_ url: URL) async throws -> Data
}

// MARK: - Implementation

final class LoadImageDataUseCase {

    @LazyInjected(\.loadImageDataRespository) private var loadImageDataRespository
}

extension LoadImageDataUseCase: LoadImageDataUseCaseProtocol {

    func loadimageData(_ url: URL) async throws -> Data {
        try await loadImageDataRespository.loadimageData(url)
    }
}
