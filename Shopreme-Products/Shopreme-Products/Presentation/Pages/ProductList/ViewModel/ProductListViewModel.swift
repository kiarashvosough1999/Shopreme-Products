//
//  ProductListViewModel.swift
//  Shopreme-Products
//
//  Created by Kiarash Vosough on 7/10/23.
//

import Foundation
import Combine
import Factory

// MARK:  Abstarction

protocol ProductListViewModelProtocol {
    
    var didReceivedSnapshot: AnyPublisher<[ProductSnapShot], Never> { get }
    var shouldStartActivity: AnyPublisher<LabledActivityViewModel?, Never> { get }

    func getHeaderViewModel(for indexPath: IndexPath) -> CollectionViewHeaderReusableViewModel?
    func fetchProducts()
    func getProductCollectionViewCellViewModel(for item: ProductCollectionViewCellModel) -> ProductCollectionViewCellViewModelProtocol
}

// MARK: - Implementation

final class ProductListViewModel {

    // MARK: - Properties

    private var categories: CurrentValueSubject<[ProductSnapShot], Never>
    private var activitySubject: PassthroughSubject<LabledActivityViewModel?, Never>
    private var fetchTask: Task<Void, Never>?
    
    // MARK: - Dependencies

    @LazyInjected(\.categorizedProductsUseCase) private var categorizedProductsUseCase

    // MARK: - LifeCycle

    init() {
        self.categories = CurrentValueSubject<[ProductSnapShot], Never>([])
        self.activitySubject = PassthroughSubject<LabledActivityViewModel?, Never>()
    }
}

extension ProductListViewModel: ProductListViewModelProtocol {

    var didReceivedSnapshot: AnyPublisher<[ProductSnapShot], Never> {
        categories.eraseToAnyPublisher()
    }
    
    var shouldStartActivity: AnyPublisher<LabledActivityViewModel?, Never> {
        activitySubject.eraseToAnyPublisher()
    }

    func fetchProducts() {
        let activityModel = LabledActivityViewModel(loadingDescription: "Loading")
        self.activitySubject.send(activityModel)
        fetchTask = Task {
            do {
                let result = try await categorizedProductsUseCase.fetch()
                self.activitySubject.send(nil)
                categories.send(map(result))
            } catch {
                self.activitySubject.send(nil)
            }
        }
    }

    private func map(_ result:  [ProductCategoryEntity]) -> [ProductSnapShot] {
        result.map { category in
            ProductSnapShot(
                section: ProductListSection(title: category.title),
                items: category.products.map { product in
                    ProductListItem.simpleProduct(
                        item: ProductCollectionViewCellModel(
                            imageURL: product.imageURL,
                            title: product.title,
                            price: product.price.formatted(.currency(code: "EUR")),
                            strikePrefix: "",
                            strikePrice: product.strikePrice?.formatted(.currency(code: "EUR")) ?? ""
                        )
                    )
                }
            )
        }
    }
    
    func getHeaderViewModel(for indexPath: IndexPath) -> CollectionViewHeaderReusableViewModel? {
        guard let category = categories.value[safe: indexPath.section] else { return nil }
        return CollectionViewHeaderReusableViewModel(title: category.section.title)
    }
    
    func getProductCollectionViewCellViewModel(
        for item: ProductCollectionViewCellModel
    ) -> ProductCollectionViewCellViewModelProtocol {
        ProductCollectionViewCellViewModel(
            model: item
        )
    }
}

fileprivate extension Collection where Index == Int {
    subscript(safe index: Int) -> Element? {
        get {
            guard index < self.count else { return nil }
            return self[index]
        }
    }
}
