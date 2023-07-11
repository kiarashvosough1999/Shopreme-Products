//
//  ImageContainingCell.swift
//  Shopreme-Products
//
//  Created by Kiarash Vosough on 7/10/23.
//

import UIKit

final class AsyncUIImageView: UIImageView {

    override var image: UIImage? {
        get {
            super.image
        } set {
            UIView.transition(with: self, duration: 2.0,  options: [.transitionCrossDissolve, .curveEaseInOut]) {
                super.image = newValue
            }
        }
    }
    
    init() {
        super.init(image: .image(.no_image_high_res))
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
