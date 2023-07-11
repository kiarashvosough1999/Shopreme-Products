//
//  ProductDetailsViewController.swift
//  Shopreme-Products
//
//  Created by Kiarash Vosough on 7/11/23.
//

import UIKit
import Combine

final class ProductDetailsViewController: UIViewController {

    private var cancellables: Set<AnyCancellable>

    // MARK: - Views

    private lazy var tableView: UITableView = UITableView(frame: .zero)
    private lazy var closeButton: CloseButton = CloseButton()

    var tableHeaderView: StretchyTableHeaderView? {
        tableView.tableHeaderView as? StretchyTableHeaderView
    }

    // MARK: - DataSource

    private lazy var dataSource: UITableViewDiffableDataSource<ProductDetailsSections, ProductDetailsItems> = generateDataSource(tableView: tableView)

    // MARK: - Inputs

    private let viewModel: ProductDetailsViewModelProtocol
    private let routing: ProductDetailsRouting

    // MARK: - LifeCycle
    
    init(
        viewModel: ProductDetailsViewModelProtocol,
        routing: ProductDetailsRouting
    ) {
        self.viewModel = viewModel
        self.routing = routing
        self.cancellables = Set<AnyCancellable>()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareViews()
        bindToViewModel()
        viewModel.fetchImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = .white
        navigationItem.hidesBackButton = true
        title = ""
    }

    // MARK: - Preparing Views

    private func prepareViews() {
        view.backgroundColor = .color(.background)
        prepareTableView()
        prepareCloseButton()
    }
    
    private func prepareTableView() {
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TitleCell")
        tableView.backgroundColor = .clear
        tableView.separatorColor = .clear

        let frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: view.bounds.height/3)
        let headerView = StretchyTableHeaderView(frame: frame)
        self.tableView.tableHeaderView = headerView
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    private func prepareCloseButton() {
        let action = UIAction { [weak self] _ in
            guard let self else { return }
            self.viewModel.closeButtonTapped()
        }
        closeButton.addAction(action, for: .primaryActionTriggered)
        closeButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            closeButton.widthAnchor.constraint(equalToConstant: 32),
            closeButton.heightAnchor.constraint(equalTo: closeButton.widthAnchor)
        ])
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: closeButton)
    }
    
    private func bindToViewModel() {
        viewModel
            .didReceivedSnapshotPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] snapshotModel in
                guard let self else { return }
                var snapshot = NSDiffableDataSourceSnapshot<ProductDetailsSections, ProductDetailsItems>()
                snapshot.appendSections([snapshotModel.section])
                snapshot.appendItems(snapshotModel.item)
                self.dataSource.apply(snapshot)
            }
            .store(in: &cancellables)
        
        viewModel
            .imageLoadedPublisher
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .map { UIImage(data: $0) }
            .sink { [weak self] image in
                guard let self else { return }
                self.tableHeaderView?.image = image
            }
            .store(in: &cancellables)
        
        viewModel
            .closePagePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self else { return }
                self.routing.closeCurrentPage()
            }
            .store(in: &cancellables)
    }
}

// MARK: - UIGestureRecognizerDelegate

extension ProductDetailsViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer
    ) -> Bool {
        return true
    }
}
