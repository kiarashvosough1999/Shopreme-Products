//
//  ProductCollectionViewCellViewModelProtocol.swift
//  Shopreme-Products
//
//  Created by Kiarash Vosough on 7/10/23.
//

import Foundation
import Combine
import Factory

// MARK: Abstraction

protocol ProductCollectionViewCellViewModelProtocol {
    
    var imageLoadedPublisher: AnyPublisher<Data?, Never> { get }

    var model: ProductCollectionViewCellModel { get }

    func prepareForReuse()
}

// MARK: - Implementation

final class ProductCollectionViewCellViewModel {

    // MARK: - Properties

    private var loadTask: Task<Void, Never>?
    private let imageLoadedSubject: CurrentValueSubject<Data?, Never>
    private let _model: ProductCollectionViewCellModel

    // MARK: - Dependencies

    @LazyInjected(\.loadImageDataUseCase) private var loadImageDataUseCase

    // MARK: - LifeCycle

    init(model: ProductCollectionViewCellModel) {
        self._model = model
        self.imageLoadedSubject = CurrentValueSubject<Data?, Never>(nil)
        loadTask = Task {
            do {
                let data = try await loadImageDataUseCase.loadimageData(model.imageURL)
                guard Task.isCancelled == false else { return }
                imageLoadedSubject.send(data)
            } catch {}
        }
    }
}

extension ProductCollectionViewCellViewModel: ProductCollectionViewCellViewModelProtocol {

    var imageLoadedPublisher: AnyPublisher<Data?, Never> {
        imageLoadedSubject.eraseToAnyPublisher()
    }

    var model: ProductCollectionViewCellModel {
        _model
    }
    
    func prepareForReuse() {
        loadTask?.cancel()
    }
}
