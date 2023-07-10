//
//  Container.swift
//  Shopreme-Products
//
//  Created by Kiarash Vosough on 7/11/23.
//

import Factory

extension Container {

    private var network: Factory<NetworkServices> {
        Factory(self) {
            NetworkServices()
        }
    }

    var categorizedProductsRepository: Factory<CategorizedProductsRepositoryProtocol> {
        Factory(self) { self.network() }
    }

    var loadImageDataRespository: Factory<LoadImageDataRespositoryProtocol> {
        Factory(self) { self.network() }
    }
}
