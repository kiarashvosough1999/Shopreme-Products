//
//  Assets+Images.swift
//  Shopeme-Products
//
//  Created by Kiarash Vosough on 7/10/23.
//

import UIKit.UIImage

extension Assets {
    
    enum Images: String {
        case ic_close
        case no_image_high_res
    }
}


extension Assets.Images {

    var image: UIImage? {
        UIImage(named: rawValue)
    }
}

extension UIImage {
    static func image(_ key: Assets.Images) -> UIImage {
        key.image!
    }
}
