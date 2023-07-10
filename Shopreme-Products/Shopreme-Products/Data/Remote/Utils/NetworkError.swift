//
//  NetworkError.swift
//  Shopeme-Products
//
//  Created by Kiarash Vosough on 7/7/23.
//

enum NetworkError: Error {
    case failedHTTPURLResponseConversion
    case apiURLException
    case requestFailed
    case emptyToken
    
    var description: String { "" }
}
