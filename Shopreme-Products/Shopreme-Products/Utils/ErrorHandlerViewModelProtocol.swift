//
//  ErrorHandlerViewModelProtocol.swift
//  Shopreme-Products
//
//  Created by Kiarash Vosough on 7/11/23.
//

import Combine
import Dispatch
import UIKit

protocol ErrorHandlerViewModelProtocol {
    var shouldStartRetryPublisher: AnyPublisher<RetryButtonModel?, Never> { get }
}

protocol ErrorHandlerViewProtocol: UIViewController, RetryButtonProtocol {}

extension ErrorHandlerViewProtocol {

    @MainActor
    func handleError(on viewModel: ErrorHandlerViewModelProtocol, action: UIAction) -> AnyCancellable {
        viewModel
            .shouldStartRetryPublisher
            .receive(on: DispatchQueue.main)
            .sink { @MainActor [weak self] show in
                guard let self else { return }
                if let show {
                    self.showRetryButton(subtitle: show.subtitle, with: action)
                } else {
                    self.removeRetryButton()
                }
            }
    }
}
