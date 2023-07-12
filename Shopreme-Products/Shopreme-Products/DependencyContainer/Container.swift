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
        .scope(.singleton)
    }

    var categorizedProductsRepository: Factory<CategorizedProductsRepositoryProtocol> {
        Factory(self) { self.network() }
    }

    var loadImageDataRespository: Factory<LoadImageDataRespositoryProtocol> {
        Factory(self) { self.network() }
    }
    
    var categorizedProductsUseCase: Factory<FetchCategorizedProductsUseCaseProtocol> {
        Factory(self) { FetchCategorizedProductsUseCase() }
    }

    var loadImageDataUseCase: Factory<LoadImageDataUseCaseProtocol> {
        Factory(self) { LoadImageDataUseCase() }
    }
    
    var feedBackGenerator: Factory<FeedBackGeneratorProtocol> {
        Factory(self) { HapticServices() }
    }
}
