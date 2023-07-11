//
//  ProductDetailsViewController+DataSource.swift
//  Shopreme-Products
//
//  Created by Kiarash Vosough on 7/11/23.
//

import UIKit

extension ProductDetailsViewController {

    func generateDataSource(
        tableView: UITableView
    ) -> UITableViewDiffableDataSource<ProductDetailsSections, ProductDetailsItems> {
        UITableViewDiffableDataSource(tableView: tableView) { tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleCell", for: indexPath)
            var contentConfiguration = cell.defaultContentConfiguration()
            switch itemIdentifier {
            case .title(let title):
                title.update(configuration: &contentConfiguration)
            case .price(let price):
                price.update(configuration: &contentConfiguration)
            case .description(let desc):
                desc.update(configuration: &contentConfiguration)
            }
            if #available(iOS 16.0, *) {
                var back = cell.defaultBackgroundConfiguration()
                back.backgroundColor = .clear
                cell.backgroundConfiguration = back
            } else {
                cell.contentView.backgroundColor = .clear
            }
            cell.contentConfiguration = contentConfiguration
            return cell
        }
    }
}
