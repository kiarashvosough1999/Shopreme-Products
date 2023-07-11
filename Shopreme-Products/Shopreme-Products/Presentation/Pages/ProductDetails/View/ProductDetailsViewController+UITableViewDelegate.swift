//
//  ProductDetailsViewController+UITableViewDelegate.swift
//  Shopreme-Products
//
//  Created by Kiarash Vosough on 7/11/23.
//

import UIKit

extension ProductDetailsViewController: UITableViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        tableHeaderView?.scrollViewDidScroll(scrollView: scrollView)
    }
}
