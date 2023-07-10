//
//  PageLoadingProtocol.swift
//  Shopreme-Products
//
//  Created by Kiarash Vosough on 7/11/23.
//

import UIKit

protocol PageLoadingProtocol {}

extension PageLoadingProtocol where Self: UIViewController {

    private var tag: Int { -923 }
    
    @MainActor
    func shouldShowActivityView(model: LabledActivityViewModel?) {
        if let model {
            let activityView = model.makeContentView()
            activityView.tag = tag
            activityView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(activityView)
            NSLayoutConstraint.activate([
                activityView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                activityView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                activityView.topAnchor.constraint(equalTo: view.topAnchor),
                activityView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])
        } else {
            let activityView = view.viewWithTag(tag)
            activityView?.removeFromSuperview()
        }
    }
}
