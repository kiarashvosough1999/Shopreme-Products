//
//  JSONLoader++JSONMocks.swift
//  Shopreme-ProductsTests
//
//  Created by Kiarash Vosough on 7/7/23.
//

import Foundation
@testable import Shopreme_Products

extension JSONLoader {

    func loadCategorizedProducts() throws -> CategoriesEntity {
        try loadJSON(name: "categorizedProducts", as: CategoriesEntity.self)
    }
}
