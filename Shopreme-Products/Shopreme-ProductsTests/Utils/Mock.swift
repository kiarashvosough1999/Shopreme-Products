//
//  Mock.swift
//  Shopreme-ProductsTests
//
//  Created by Kiarash Vosough on 7/11/23.
//

import Foundation

protocol Mock<Action> {

    associatedtype Action: Equatable

    var actions: MockActions<Action> { get }
    
    func register(_ action: Action)
    
    func verify(file: StaticString, line: UInt)
}

extension Mock {
    
    func register(_ action: Action) {
        actions.register(action)
    }
    
    public func verify(file: StaticString = #file, line: UInt = #line) {
        actions.verify(file: file, line: line)
    }
}
