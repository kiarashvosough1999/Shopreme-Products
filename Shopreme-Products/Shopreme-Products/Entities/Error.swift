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
    case unknownError
    
    var errorDescription: String? {
        switch self {
        case .networkUnavailable:
            return .localized(.die_internetverbindung_scheint_offline_zu_sein)
        default: return nil
        }
    }
}
