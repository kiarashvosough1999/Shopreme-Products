//
//  ProductDetailsViewModel.swift
//  Shopreme-Products
//
//  Created by Kiarash Vosough on 7/11/23.
//

import Foundation
import Combine
import Factory

// MARK:  Abstarction

protocol ProductDetailsViewModelProtocol {

    var imageLoadedPublisher: AnyPublisher<Data?, Never> { get }
    var didReceivedSnapshotPublisher: AnyPublisher<ProductSnapShot, Never> { get }
    var closePagePublisher: AnyPublisher<Void, Never> { get }
    
    func fetchImage()
    func closeButtonTapped()
}

// MARK: - Implementation

final class ProductDetailsViewModel {

    // MARK: - Properties

    private let didReceivedSnapshotSubject: CurrentValueSubject<ProductSnapShot, Never>
    private let imageLoadedSubject: PassthroughSubject<Data?, Never>
    private let closePageSubject: PassthroughSubject<Void, Never>
    private let product: ProductEntity
    private var loadTask: Task<Void, Never>?

    // MARK: - Dependencies

    @LazyInjected(\.loadImageDataUseCase) private var loadImageDataUseCase
    @LazyInjected(\.categorizedProductsUseCase) private var categorizedProductsUseCase

    // MARK: - LifeCycle

    init(product: ProductEntity) {
        self.product = product
        self.imageLoadedSubject = PassthroughSubject<Data?, Never>()
        self.closePageSubject = PassthroughSubject<Void, Never>()
        
        let context = ProductEntityToProductSnapShotMapper.Context(
            concyrrencyCode: "EUR",
            section: .main
        )
        self.didReceivedSnapshotSubject = CurrentValueSubject<ProductSnapShot, Never>(
            ProductEntityToProductSnapShotMapper().map(product, context: context)
        )
    }

    private func loadImage(with url: URL) {
        loadTask = Task {
            do {
                let data = try await loadImageDataUseCase.loadimageData(url)
                guard Task.isCancelled == false else { return }
                imageLoadedSubject.send(data)
            } catch {}
        }
    }
}

extension ProductDetailsViewModel: ProductDetailsViewModelProtocol {

    var imageLoadedPublisher: AnyPublisher<Data?, Never> {
        imageLoadedSubject.eraseToAnyPublisher()
    }

    var didReceivedSnapshotPublisher: AnyPublisher<ProductSnapShot, Never> {
        didReceivedSnapshotSubject.eraseToAnyPublisher()
    }

    var closePagePublisher: AnyPublisher<Void, Never> {
        closePageSubject.eraseToAnyPublisher()
    }

    func fetchImage() {
        loadImage(with: product.imageURL)
    }
    
    func closeButtonTapped() {
        closePageSubject.send()
    }
}
