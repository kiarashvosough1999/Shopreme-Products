//
//  API.swift
//  Shopeme-Products
//
//  Created by Kiarash Vosough on 7/7/23.
//

import Foundation

protocol API {
    var method: HTTPMethod { get }
    var gateway: GateWays { get }
    var route: String { get }
    var headerParams: [String: Any] { get }
    var useCache: Bool { get }
    
    func asURLRequest() throws -> URLRequest
}

extension API {

    var headerParams: [String: Any] { [:] }
    var useCache: Bool { false }

    func asURLRequest() throws -> URLRequest {
        guard let gateway = gateway.get() else {
            throw NetworkError.apiURLException
        }
        let url = gateway.appendingPathComponent(route)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")

        if useCache { urlRequest.cachePolicy = .returnCacheDataElseLoad }
        
        headerParams.forEach { param in
            urlRequest.setValue("\(param.value)", forHTTPHeaderField: param.key)
        }
        return urlRequest
    }
}
