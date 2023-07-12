//
//  LoadImageDataRespositoryProtocol.swift
//  Shopreme-Products
//
//  Created by Kiarash Vosough on 7/11/23.
//

import Foundation

protocol LoadImageDataRespositoryProtocol {
    func loadimageData(_ url: URL) async throws -> Data
}
