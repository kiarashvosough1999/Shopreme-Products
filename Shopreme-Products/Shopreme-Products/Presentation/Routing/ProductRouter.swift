//
//  ProductRouter.swift
//  Shopreme-Products
//
//  Created by Kiarash Vosough on 7/11/23.
//

import UIKit

final class ProductRouter: RouterProtocol {

    private weak var navigationController: UINavigationController?
    
    static func route() -> UIViewController {
        let viewModel = ProductListViewModel()
        let router = ProductRouter()
        let controller = ProductListViewController(
            viewModel: viewModel,
            routing: router
        )

        let navigationController = UINavigationController(rootViewController: controller)

        router.navigationController = navigationController
        return navigationController
    }
}

extension ProductRouter: ProductListRoutingProtocol {

    func openProductDetails(product: ProductEntity) {
        let viewModel = ProductDetailsViewModel(product: product)
        let controller = ProductDetailsViewController(viewModel: viewModel, routing: self)
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension ProductRouter: ProductDetailsRouting {
    func closeCurrentPage() {
        navigationController?.popViewController(animated: true)
    }
}
