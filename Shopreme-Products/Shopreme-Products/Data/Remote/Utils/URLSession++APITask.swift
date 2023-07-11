//
//  URLSession++APITask.swift
//  Shopreme-Products
//
//  Created by Kiarash Vosough on 7/7/23.
//

import Foundation

extension URLSession {

    internal struct APIResponse {
        let data: Data
        let httpResponse: HTTPURLResponse

        var statusCode: StatusCode {
            StatusCode(rawValue: httpResponse.statusCode) ?? .unknown
        }
        
        func decode<M>(to modelType: M.Type) throws -> M where M: Decodable {
            try JSONDecoder().decode(modelType, from: data)
        }
    }

    internal func data(for api: any API) async throws -> APIResponse {
        let (data, response) = try await self.data(for: try api.asURLRequest())

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.failedHTTPURLResponseConversion
        }

        return APIResponse(data: data, httpResponse: httpResponse)
    }
}
