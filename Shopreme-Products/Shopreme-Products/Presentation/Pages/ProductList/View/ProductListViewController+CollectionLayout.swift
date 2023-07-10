//
//  ProductListViewController+CollectionLayout.swift
//  Shopreme-Products
//
//  Created by Kiarash Vosough on 7/10/23.
//

import Foundation
import UIKit

extension ProductListViewController {
    
    private var configuration: UICollectionViewCompositionalLayoutConfiguration {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .vertical
        config.interSectionSpacing = 16
        return config
    }
    
    func generateLayout() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout(sectionProvider: { [weak self] (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            guard let self else { return nil }

            return self.generateMainLayout()
        }, configuration: configuration)
    }
    
    private func generateMainLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1/2.3),
            heightDimension: .estimated(90)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(90)
        )

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item, item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)

        group.interItemSpacing = .flexible(4)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 16
        section.contentInsets = NSDirectionalEdgeInsets (top: 0, leading: 10, bottom: 0, trailing: 10)
        section.orthogonalScrollingBehavior = .none

        let headerItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(20)
        )

        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerItemSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        section.boundarySupplementaryItems = [headerItem]
        
        return section
    }
}
