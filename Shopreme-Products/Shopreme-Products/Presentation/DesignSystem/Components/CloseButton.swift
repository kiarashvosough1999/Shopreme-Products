//
//  CloseButton.swift
//  Shopreme-Products
//
//  Created by Kiarash Vosough on 7/10/23.
//

import UIKit

final class CloseButton: UIButton {
    
    init() {
        super.init(frame: .zero)
        var config = UIButton.Configuration.plain()
        config.image = Assets.Images.ic_close.image
        self.configuration = config
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
