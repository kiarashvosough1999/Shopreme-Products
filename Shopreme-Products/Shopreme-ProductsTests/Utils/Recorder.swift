//
//  Recorder.swift
//  Shopreme-ProductsTests
//
//  Created by Kiarash Vosough on 7/11/23.
//

import Combine
import XCTest

extension Recorder {
    
    enum Record {
        case value(Input)
        case completion(Subscribers.Completion<Failure>)
        
        var value: Input? {
            if case let .value(input) = self {
                return input
            }
            return nil
        }
        
        var isCompleted: Bool {
            if case .completion = self {
                return true
            }
            return false
        }
    }
}

extension Recorder.Record: CustomStringConvertible {
    var description: String {
        switch self {
        case let .value(inputValue):
            return "\(inputValue)"
        case let .completion(completionValue):
            return "\(completionValue)"
        }
    }
}


final class Recorder<Input, Failure: Error> {

    var records: [Record] = [] {
        didSet {
            if shouldStopRecording {
                expectation.fulfill()
            }
        }
    }
    
    func waitForRecords(
        timeout: TimeInterval = 1,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        defer { subscription?.cancel() }
        
        let result = waiter.wait(for: [expectation], timeout: timeout)
        if result != .completed {
            func valueFormatter(_ count: Int) -> String {
                "\(count) value" + (count == 1 ? "" : "s")
            }
            
            if let numberOfRecords = self.numberOfRecords {
                XCTFail("""
        Waiting for \(valueFormatter(numberOfRecords)) timed out.
        Received only \(valueFormatter(records.count)).
        """,
                        file: file,
                        line: line)
            } else {
                XCTFail("""
        Waiting for the subscription to complete timed out.
        Received only \(valueFormatter(records.count)).
        """,
                        file: file,
                        line: line)
            }
        }
    }

    func waitAndCollectRecords(
        timeout: TimeInterval = 1,
        file: StaticString = #file,
        line: UInt = #line
    ) -> [Record] {
        waitForRecords(timeout: timeout, file: file, line: line)
        return records
    }

    init(numberOfRecords: Int? = 0) {
        if let numberOfRecords = numberOfRecords {
            assert(numberOfRecords > 0, "numberOfRecords must be greater than zero.")
        }
        self.numberOfRecords = numberOfRecords
    }
    
    internal func append(record: Record) {
        records.append(record)
    }
    
    private let numberOfRecords: Int?
    
    private let expectation = XCTestExpectation(description: "All values received")
    private let waiter = XCTWaiter()
    
    private var subscription: Subscription?
}

extension Recorder {
    private var shouldStopRecording: Bool {
        if let numberOfRecords = self.numberOfRecords {
            return numberOfRecords == records.count
        }
        
        if case .completion = records.last { return true }
        
        return false
    }
}

extension Recorder: Subscriber {
    func receive(subscription: Subscription) {
        assert(self.subscription == nil)
        self.subscription = subscription
        subscription.request(.unlimited)
    }
    
    func receive(_ input: Input) -> Subscribers.Demand {
        let action = { self.append(record: .value(input)) }
        if Thread.current.isMainThread {
            action()
        } else {
            DispatchQueue.main.async(execute: action)
        }
        return .none
    }
    
    func receive(completion: Subscribers.Completion<Failure>) {
        let action = { self.append(record: .completion(completion)) }
        if Thread.current.isMainThread {
            action()
        } else {
            DispatchQueue.main.async(execute: action)
        }
    }
}

extension Publisher {

    func record(numberOfRecords: Int? = nil) -> Recorder<Output, Failure> {
        let recorder = Recorder<Output, Failure>(numberOfRecords: numberOfRecords)
        subscribe(recorder)
        return recorder
    }
}

func XCTAssertRecordedValues<Input: Equatable, Failure: Error>(
    _ records: [Recorder<Input, Failure>.Record],
    _ expectedValues: [Input],
    file: StaticString = #file,
    line: UInt = #line
) {
    let values = records.compactMap { record -> Input? in
        if case let .value(inputValue) = record {
            return inputValue
        } else {
            return nil
        }
    }
    XCTAssertEqual(values, expectedValues, file: file, line: line)
}

func XCTAssertEqual<Input: Equatable, Failure: Error>(
    _ records: [Recorder<Input, Failure>.Record],
    _ expectedValues: [Recorder<Input, Failure>.Record],
    file: StaticString = #file,
    line: UInt = #line
) {
    func fail() {
        XCTFail("Records not equal. See the console output for more info.", file: file, line: line)
    }
    
    guard records.count == expectedValues.count else {
        fail(); return
    }
    
    zip(records, expectedValues).forEach {
        if $0 != $1 {
            fail(); return
        }
    }
}


internal func != <Input: Equatable, Failure: Error>(lhs: Recorder<Input, Failure>.Record, rhs: Recorder<Input, Failure>.Record) -> Bool {
    !(lhs == rhs)
}

internal func == <Input: Equatable, Failure: Error>(lhs: Recorder<Input, Failure>.Record, rhs: Recorder<Input, Failure>.Record) -> Bool {
    switch (lhs, rhs) {
    case let (.value(lValue), .value(rValue)):
        return lValue == rValue
        
    case (.completion(.finished), .completion(.finished)):
        return true
        
    case let (.completion(.failure(lError)), .completion(.failure(rError))):
        return lError.localizedDescription == rError.localizedDescription
        
    default:
        return false
    }
}

extension Publisher {
    func recordOnce() -> Recorder<Output, Failure> {
        let recorder = Recorder<Output, Failure>(numberOfRecords: 1)
        subscribe(recorder)
        return recorder
    }
}

extension Recorder {
    
    func waitAndCollectFirstRecord(
        timeout: TimeInterval = 1,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Input? {
        let first = waitAndCollectRecords(timeout: timeout, file: file, line: line).compactMap { $0.value }.first
        return first
    }
    
    func waitAndCollectFirstRecord(
        timeout: TimeInterval = 1,
        n: Int,
        file: StaticString = #file,
        line: UInt = #line
    ) -> [Input] {
        let values = waitAndCollectRecords(timeout: timeout, file: file, line: line).prefix(n).compactMap { $0.value }
        return values
    }
    
    
    func waitAndCollectLastRecord(
        timeout: TimeInterval = 1,
        file: StaticString = #file,
        line: UInt = #line
    ) -> Input? {
        let last = waitAndCollectRecords(timeout: timeout, file: file, line: line).compactMap { $0.value }.last
        return last
    }
    
    func waitAndCollectLastRecord(
        timeout: TimeInterval = 1,
        n: Int,
        file: StaticString = #file,
        line: UInt = #line
    ) -> [Input] {
        let values = waitAndCollectRecords(timeout: timeout, file: file, line: line).suffix(n).compactMap { $0.value }
        return values
    }
}
