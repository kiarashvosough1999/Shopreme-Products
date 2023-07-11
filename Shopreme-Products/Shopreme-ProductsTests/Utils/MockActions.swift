//
//  MockActions.swift
//  Shopreme-ProductsTests
//
//  Created by Kiarash Vosough on 7/11/23.
//

import Foundation
import XCTest

final class MockActions<Action> where Action: Equatable {

    private var expected: [Action]
    private var factual: [Action]
    private var shouldIgnoreAction: ((Action) -> Bool)
    
    init(
        expected: [Action] = [],
        shouldIgnoreAction: @escaping ((Action) -> Bool) = { _ in false }
    ) {
        self.expected = expected
        self.shouldIgnoreAction = shouldIgnoreAction
        self.factual = []
    }
    
    func register(_ action: Action) {
        factual.append(action)
    }

    func verify(file: StaticString = #file, line: UInt = #line) {
        let nonIgnoredfactual = factual.filter { shouldIgnoreAction($0) == false }
        if nonIgnoredfactual.contains(expected) { return }
        let factualNames = nonIgnoredfactual.map { "." + String(describing: $0) }
        let expectedNames = expected.map { "." + String(describing: $0) }
        XCTFail("\(name)\n\nExpected:\n\n\(expectedNames)\n\nReceived:\n\n\(factualNames)", file: file, line: line)
    }
    
    private var name: String {
        let fullName = String(describing: self)
        let nameComponents = fullName.components(separatedBy: ".")
        return nameComponents.dropLast().last ?? fullName
    }
}
