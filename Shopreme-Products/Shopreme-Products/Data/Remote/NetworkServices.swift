//
//  NetworkServices.swift
//  Shopeme-Products
//
//  Created by Kiarash Vosough on 7/7/23.
//

import Foundation

final class NetworkServices {
    
    let session: URLSession
    let cache: URLCache
    var reachability: NetworkReachability { NetworkReachability() }
    
    init() {
        let configuration = URLSessionConfiguration.default
        self.session = URLSession(configuration: configuration)
        self.cache = URLCache(memoryCapacity: Int(3e+7), diskCapacity: Int(5e+7))
        configuration.urlCache = self.cache
    }
}

