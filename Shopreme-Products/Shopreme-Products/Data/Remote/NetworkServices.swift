//
//  NetworkServices.swift
//  Shopreme-Products
//
//  Created by Kiarash Vosough on 7/7/23.
//

import Foundation

final class NetworkServices {
    
    let session: URLSession
    let cache: URLCache
    
    init() {
        let configuration = URLSessionConfiguration.default
        self.session = URLSession(configuration: configuration)
        self.cache = URLCache(memoryCapacity: Int(3e+7), diskCapacity: Int(5e+7))
        configuration.urlCache = self.cache
    }

    func throwErrorIfOffline(_ error: Error) throws {
        let error = error as NSError
        guard error.code == -1009, error.domain == NSURLErrorDomain else { throw error }
        throw NonDomainError.networkUnavailable
    }
}

