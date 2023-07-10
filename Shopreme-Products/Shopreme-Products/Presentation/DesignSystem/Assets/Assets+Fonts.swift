//
//  Assets+Fonts.swift
//  Shopeme-Products
//
//  Created by Kiarash Vosough on 7/10/23.
//

import UIKit.UIFont

extension Assets {

    /// 12 -> caption
    /// 15 -> body2
    /// 16 -> body
    /// 18 -> title3
    /// 24 -> title2
    /// 32 -> title
    enum Fonts {

        enum Regular {
            static let body = UIFont(name: "SFProText-Regular", size: 16)!
            static let caption = UIFont(name: "SFProText-Regular", size: 12)!
        }

        enum Black {
            static let body = UIFont(name: "SFProDisplay-Black", size: 16)!
            static let title2 = UIFont(name: "SFProDisplay-Black", size: 24)!
            static let title = UIFont(name: "SFProDisplay-Black", size: 32)!
        }

        enum Semibold {
            static let body2 = UIFont(name: "SFProText-Semibold", size: 15)!
        }
        
        enum Medium {
            static let title3 = UIFont(name: "SFProDisplay-Medium", size: 18)!
            static let caption = UIFont(name: "SFProDisplay-Medium", size: 12)!
        }
    }
}
