//
//  ProductDetailsItems.swift
//  Shopreme-Products
//
//  Created by Kiarash Vosough on 7/11/23.
//

import Foundation
import UIKit

enum ProductDetailsItems: Hashable {
    case title(Title)
    case price(Price)
    case description(Description)
}

extension ProductDetailsItems {

    struct Title: Hashable {
        let title: String
    }
    
    struct Price: Hashable {
        let price: String
    }
    
    struct Description: Hashable {
        let description: String
    }
}
