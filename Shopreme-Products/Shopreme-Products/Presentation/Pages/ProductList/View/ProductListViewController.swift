//
//  ProductListViewController.swift
//  Shopreme-Products
//
//  Created by Kiarash Vosough on 7/10/23.
//

import UIKit
import Combine

final class ProductListViewController: UIViewController, PageLoadingProtocol {

    private var cancellables: Set<AnyCancellable>

    // MARK: - Views

    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(
            frame: .zero,
            collectionViewLayout: generateLayout()
        )
        view.backgroundColor = .clear
        return view
    }()

    // MARK: - DataSource

    private lazy var dataSource: UICollectionViewDiffableDataSource<ProductListSection, ProductListItem> = generateDataSource(for: collectionView, viewModel: viewModel)

    // MARK: - Inputs
    
    private let viewModel: ProductListViewModelProtocol
    private let routing: ProductListRoutingProtocol

    init(
        viewModel: ProductListViewModelProtocol,
        routing: ProductListRoutingProtocol
    ) {
        self.viewModel = viewModel
        self.routing = routing
        self.cancellables = Set<AnyCancellable>()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindToViewModel()
        prepare()
        viewModel.fetchProducts()
    }

    // MARK: - Preparing Views

    private func prepare() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = .localized(.obst_und_gemüse).capitalized
        view.backgroundColor = .color(.background)
        prepareCollectionView()
    }

    private func prepareCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    func bindToViewModel() {
        viewModel
            .didReceivedSnapshot
            .filter { $0.isEmpty == false }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] snapshot in
                guard let self else { return }
                self.applySnapshot(snapshot)
            }
            .store(in: &cancellables)

        viewModel
            .shouldStartActivity
            .receive(on: DispatchQueue.main)
            .sink { [weak self] model in
                guard let self else { return }
                self.shouldShowActivityView(model: model)
            }
            .store(in: &cancellables)
    }
    
    private func applySnapshot(_ snapshot: [ProductSnapShot]) {
        var diffableSnapshot = NSDiffableDataSourceSnapshot<ProductListSection, ProductListItem>()
        snapshot.forEach { category in
            diffableSnapshot.appendSections([category.section])
            diffableSnapshot.appendItems(category.items)
        }
        dataSource.apply(diffableSnapshot)
    }
}
