//
//  ProductCategoryEntityToProductCategorySnapShotMapper.swift
//  Shopreme-Products
//
//  Created by Kiarash Vosough on 7/12/23.
//

import Foundation

struct ProductCategoryEntityToProductCategorySnapShotMapper: MapperProtocol {

    typealias From = [ProductCategoryEntity]
    typealias To = [ProductCategorySnapShot]

    struct Context {
        let currencyCode: String
    }

    func map(_ result:  [ProductCategoryEntity], context: Context) -> [ProductCategorySnapShot] {
        result.map { category in
            ProductCategorySnapShot(
                section: ProductListSection(title: category.title),
                items: category.products.map { product in
                    ProductListItem.simpleProduct(
                        item: ProductCollectionViewCellModel(
                            imageURL: product.imageURL,
                            title: product.title,
                            price: product.price.formatted(.currency(code: context.currencyCode)),
                            strikePrefix: "",
                            strikePrice: product.strikePrice?.formatted(.currency(code: context.currencyCode)) ?? ""
                        )
                    )
                }
            )
        }
    }
}
