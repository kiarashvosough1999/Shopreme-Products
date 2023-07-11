//
//  MockURL.swift
//  Shopreme-ProductsTests
//
//  Created by Kiarash Vosough on 7/7/23.
//

import Foundation

struct MockURL {
    static var urls: [URL] {
        [
            URL(string: "https://api.github.com")!,
            URL(string: "https://ap2.github.com")!,
            URL(string: "https://ap3.github.com")!,
            URL(string: "https://ap4.github.com")!,
            URL(string: "https://ap5.github.com")!,
            URL(string: "https://ap6.github.com")!,
        ]
    }
}
