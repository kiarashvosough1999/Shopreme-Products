//
//  XCAsserts.swift
//  Shopreme-ProductsTests
//
//  Created by Kiarash Vosough on 7/11/23.
//

import XCTest

func XCTAssertEqualArray<Element>(_ first: [Element], _ second: [Element]) where Element: Equatable {
    for item in first {
        let founded = second.first(where: { $0 == item })
        XCTAssertNotNil(founded)
    }
}

func XCTAssertThrowsError<T>(
    _ expression: @autoclosure () async throws -> T,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #filePath,
    line: UInt = #line,
    _ errorHandler: (_ error: Error) -> Void = { _ in }
) async {
    do {
        _ = try await expression()
        XCTAssert(true, file: file, line: line)
    } catch {
        errorHandler(error)
    }
}

func XCTAssertNoThrowsError<T>(
    _ expression: @autoclosure () async throws -> T,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #filePath,
    line: UInt = #line
) async {
    do {
        _ = try await expression()
    } catch {
        XCTAssert(true, file: file, line: line)
    }
}

func XCTAssertNotNilNil<T>(
    _ expression: @autoclosure () throws -> T??,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #filePath,
    line: UInt = #line
) rethrows {
    let res = try expression()
    switch res {
    case .none:
        XCTAssert(false)
    case .some(let wrapped):
        switch wrapped {
        case .none:
            XCTAssert(false)
        case .some:
            XCTAssert(true)
        }
    }
}

func XCTAssertNilNil<T>(
    _ expression: @autoclosure () throws -> T??,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #filePath,
    line: UInt = #line
) rethrows {
    let res = try expression()
    switch res {
    case .none:
        XCTAssert(true)
    case .some(let wrapped):
        switch wrapped {
        case .none:
            XCTAssert(true)
        case .some:
            XCTAssert(false)
        }
    }
}

func XCTAssertNilNilNil<T>(
    _ expression: @autoclosure () throws -> T???,
    _ message: @autoclosure () -> String = "",
    file: StaticString = #filePath,
    line: UInt = #line
) rethrows {
    let res = try expression()
    switch res {
    case .none:
        XCTAssert(true)
    case .some(let wrapped):
        switch wrapped {
        case .none:
            XCTAssert(true)
        case .some(let wrapped):
            switch wrapped {
            case .none:
                XCTAssert(true)
            case .some:
                XCTAssert(false)
            }
        }
    }
}
