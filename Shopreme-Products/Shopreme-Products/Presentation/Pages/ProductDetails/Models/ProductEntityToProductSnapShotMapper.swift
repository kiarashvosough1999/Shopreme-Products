//
//  ProductEntityToProductSnapShotMapper.swift
//  Shopreme-Products
//
//  Created by Kiarash Vosough on 7/12/23.
//

import Foundation

struct ProductEntityToProductSnapShotMapper: MapperProtocol {
    
    typealias From = ProductEntity
    typealias To = ProductSnapShot
    
    struct Context {
        let concyrrencyCode: String
        let section: ProductDetailsSections
    }
    
    func map(_ result: ProductEntity, context: Context) -> ProductSnapShot {
        ProductSnapShot(
            section: context.section,
            item: [
                .title(ProductDetailsItems.Title(title: result.title)),
                .price(ProductDetailsItems.Price(price: result.price.formatted(.currency(code: context.concyrrencyCode)))),
                .description(ProductDetailsItems.Description(description: result.description))
            ]
        )
    }
}
