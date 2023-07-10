//
//  NetworkServices+LoadImageDataRespositoryProtocol.swift
//  Shopreme-Products
//
//  Created by Kiarash Vosough on 7/10/23.
//

import Foundation

extension NetworkServices: LoadImageDataRespositoryProtocol {

    func loadimageData(_ url: URL) async throws -> Data {
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        if let cache = self.cache.cachedResponse(for: request)?.data {
            return cache
        } else {
            return try await session.data(for: request).0
        }
    }
}
