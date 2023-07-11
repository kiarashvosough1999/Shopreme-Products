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

protocol ProductListViewModelProtocol: ErrorHandlerViewModelProtocol {
    
    var didReceivedSnapshot: AnyPublisher<[ProductCategorySnapShot], Never> { get }
    var shouldStartActivity: AnyPublisher<LabledActivityViewModel?, Never> { get }
    var showProductDetailsPublisher: AnyPublisher<ProductEntity, Never> { get }

    func getHeaderViewModel(for indexPath: IndexPath) -> CollectionViewHeaderReusableViewModel?
    func fetchProducts()
    func getProductCollectionViewCellViewModel(for item: ProductCollectionViewCellModel) -> ProductCollectionViewCellViewModelProtocol
    func didSelectedItem(at indexPath: IndexPath)
}

// MARK: - Implementation

final class ProductListViewModel {

    // MARK: - Properties

    private let categories: CurrentValueSubject<[ProductCategoryEntity], Never>
    private let activitySubject: PassthroughSubject<LabledActivityViewModel?, Never>
    private let showProductDetailsSubject: PassthroughSubject<ProductEntity, Never>
    private let shouldStartRetrySubject: PassthroughSubject<RetryButtonModel?, Never>
    private var fetchTask: Task<Void, Never>?
    private let throttler: Throttler
    
    // MARK: - Dependencies

    @LazyInjected(\.categorizedProductsUseCase) private var categorizedProductsUseCase

    // MARK: - LifeCycle

    init() {
        self.categories = CurrentValueSubject<[ProductCategoryEntity], Never>([])
        self.activitySubject = PassthroughSubject<LabledActivityViewModel?, Never>()
        self.showProductDetailsSubject = PassthroughSubject<ProductEntity, Never>()
        self.shouldStartRetrySubject = PassthroughSubject<RetryButtonModel?, Never>()
        self.throttler = Throttler(delay: 5)
    }
}

extension ProductListViewModel: ProductListViewModelProtocol {
    
    var showProductDetailsPublisher: AnyPublisher<ProductEntity, Never> {
        showProductDetailsSubject.eraseToAnyPublisher()
    }

    var shouldStartRetryPublisher: AnyPublisher<RetryButtonModel?, Never> {
        shouldStartRetrySubject.eraseToAnyPublisher()
    }

    var didReceivedSnapshot: AnyPublisher<[ProductCategorySnapShot], Never> {
        categories
            .map(map)
            .eraseToAnyPublisher()
    }

    private func map(_ result:  [ProductCategoryEntity]) -> [ProductCategorySnapShot] {
        result.map { category in
            ProductCategorySnapShot(
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

    var shouldStartActivity: AnyPublisher<LabledActivityViewModel?, Never> {
        activitySubject.eraseToAnyPublisher()
    }

    func fetchProducts() {
        self.throttler.go { [weak self] in
            guard let self else { return }
            let activityModel = LabledActivityViewModel(
                loadingDescription: .localized(.produckte_werden_geladen).capitalized
            )
            self.activitySubject.send(activityModel)
            self.fetchTask = Task {
                do {
                    let result = try await self.categorizedProductsUseCase.fetch()
                    self.shouldStartRetrySubject.send(nil)
                    self.activitySubject.send(nil)
                    self.categories.send(result)
                } catch let error as LocalizedError {
                    self.activitySubject.send(nil)
                    self.shouldStartRetrySubject.send(
                        RetryButtonModel(subtitle: error.errorDescription ?? "")
                    )
                } catch {
                    self.activitySubject.send(nil)
                    self.shouldStartRetrySubject.send(RetryButtonModel())
                }
            }
        }
    }
    
    func getHeaderViewModel(for indexPath: IndexPath) -> CollectionViewHeaderReusableViewModel? {
        guard let category = categories.value[safe: indexPath.section] else { return nil }
        return CollectionViewHeaderReusableViewModel(title: category.title)
    }
    
    func getProductCollectionViewCellViewModel(
        for item: ProductCollectionViewCellModel
    ) -> ProductCollectionViewCellViewModelProtocol {
        ProductCollectionViewCellViewModel(
            model: item
        )
    }
    
    func didSelectedItem(at indexPath: IndexPath) {
        guard let product = categories.value[safe: indexPath.section]?.products[safe: indexPath.row] else { return }
        showProductDetailsSubject.send(product)
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
