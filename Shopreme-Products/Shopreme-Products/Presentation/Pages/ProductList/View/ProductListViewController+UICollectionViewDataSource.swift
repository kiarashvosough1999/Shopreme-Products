//
//  ProductListViewController++UICollectionViewDataSource.swift
//  Shopreme-Products
//
//  Created by Kiarash Vosough on 7/10/23.
//

import UIKit

extension ProductListViewController {

    func generateDataSource(
        for collectionView: UICollectionView,
        viewModel: ProductListViewModelProtocol
    ) -> UICollectionViewDiffableDataSource<ProductListSection, ProductListItem> {
        
        let cellRegistration = UICollectionView.CellRegistration<ProductCollectionViewCell, ProductListItem> { cell, indexPath, item in
            switch item {
            case .simpleProduct(let item):
                cell.viewModel = viewModel.getProductCollectionViewCellViewModel(for: item)
            }
        }

        let supplementaryViewRegistration = UICollectionView.SupplementaryRegistration<CollectionViewHeaderReusableView>(elementKind: UICollectionView.elementKindSectionHeader) { supplementaryView, elementKind, indexPath in
            switch elementKind {
            case UICollectionView.elementKindSectionHeader:
                guard let configuration = viewModel.getHeaderViewModel(for: indexPath) else { return }
                supplementaryView.configuration = configuration
            default:
                break
            }
        }

        let dataSource = UICollectionViewDiffableDataSource<ProductListSection, ProductListItem>(collectionView: collectionView) { collectionView, indexPath, item in

            collectionView.dequeueConfiguredReusableCell(
                using: cellRegistration,
                for: indexPath,
                item: item
            )
        }

        dataSource.supplementaryViewProvider = { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            collectionView.dequeueConfiguredReusableSupplementary(using: supplementaryViewRegistration, for: indexPath)
        }

        return dataSource
    }
}
