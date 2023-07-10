//
//  DomainError.swift
//  Shopreme-Products
//
//  Created by Kiarash Vosough on 7/7/23.
//

import Foundation

enum DomainError: LocalizedError {
    
}

enum NonDomainError: LocalizedError {
    case networkUnavailable
    case insufficientResource
}
